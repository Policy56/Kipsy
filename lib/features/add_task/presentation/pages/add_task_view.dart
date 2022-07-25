import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/dependency_container.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:kipsy/features/add_task/presentation/bloc/add_task_state.dart';
import 'package:kipsy/features/add_task/presentation/model/task_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/widgets/custom_text_field.dart';
import 'package:kipsy/features/add_task/presentation/widgets/page_header.dart';
import 'package:kipsy/features/add_task/presentation/widgets/swipe_line.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/new_task_fab.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';

class AddTask extends StatelessWidget {
  ListesOfHouseEntity liste;

  AddTask({Key? key, required this.liste}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskBloc(sl()),
      child: AddTaskView(
        liste: liste,
      ),
    );
  }
}

class AddTaskView extends StatefulWidget {
  ListesOfHouseEntity liste;
  AddTaskView({Key? key, required this.liste}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  List<Widget> customNewWidget = [];

  @override
  Widget build(BuildContext context) {
    final addTaskBloc = context.read<AddTaskBloc>();

    addTaskBloc.liste = widget.liste;
    return WillPopScope(
      onWillPop: () async {
        addTaskBloc.goBack(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.blue,
            leading: IconButton(
                onPressed: () => addTaskBloc.goBack(context),
                icon: const Icon(Icons.arrow_back_ios),
                color: ThemeManager.isDark(context)
                    ? ColorManager.lightGrey
                    : ColorManager.lightGrey),
          ),
          backgroundColor: ColorManager.blue,
          floatingActionButton: Align(
            alignment: const Alignment(1, 0.85),
            child: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (BuildContext context, AddTaskState state) {
                return SpeedDial(
                    icon: Icons.add,
                    activeIcon: Icons.add,
                    backgroundColor: ColorManager.blue,
                    useRotationAnimation: true,
                    animationCurve: Curves.elasticInOut,
                    animationDuration: const Duration(milliseconds: 300),
                    foregroundColor: ColorManager.lightGrey,
                    animationAngle: pi,
                    elevation: 5.0,
                    children: NewTaskFAB().getListButton(context));
              },
            ),
          ),
          body: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (BuildContext context, AddTaskState state) {
            customNewWidget = [];
            if (addTaskBloc.visibilityQteUnit ==
                true /* && state is AddTypeTask*/) {
              customNewWidget.add(btnQuantiteEtUnite());
              addTaskBloc.visibilityQteUnit = null;
            }

            return PageHeader(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                children: [
                  const SwipeLine(),
                  CustomTextField(
                    title: 'New task',
                    controller: addTaskBloc.titleController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                  ),
                  for (Widget item in customNewWidget) item,
                  CustomTextField(
                    title: 'Description',
                    maxLines: 12,
                    controller: addTaskBloc.descriptionController,
                    //textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const AddBtn()
                ],
              ),
            );
          })),
    );
  }

  Widget btnQuantiteEtUnite() {
    final addTaskBloc = context.read<AddTaskBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2)),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 18,
                ),
              ),
            ),
            onTap: () {
              addTaskBloc.visibilityQteUnit = false;
            },
          ),
        ),
        const Spacer(),
        Expanded(
          child: CustomTextField(
            title: 'Quantite',
            controller: addTaskBloc.quantiteController,
            keyboardType: TextInputType.number,
            maxLength: 8,
            textInputAction: TextInputAction.next,
            inputFormatter: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            maxLines: 1,
          ),
          flex: 3,
        ),
        const Spacer(),
        Expanded(
          child: CustomTextField(
            title: 'Unite',
            controller: addTaskBloc.uniteController,
            textInputAction: TextInputAction.next,
            maxLength: 8,
            maxLines: 1,
          ),
          flex: 3,
        ),
        const Spacer(),
      ],
    );
  }
}

class AddBtn extends StatelessWidget {
  const AddBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddTaskBloc bloc = context.read<AddTaskBloc>();
    return BlocConsumer<AddTaskBloc, AddTaskState>(
        listener: (BuildContext context, AddTaskState state) {
      if (state is AddTaskLoad) {
        bloc.clearControllers();
        bloc.showToast(context, TaskToastModel.addTaskSuccess);
      } else if (state is AddTaskError) {
        bloc.showToast(context, TaskToastModel.addTaskError);
      }
    }, builder: (BuildContext context, AddTaskState state) {
      if (state is AddTaskLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AddTaskError) {
        return Center(child: Text(state.msg ?? ''));
      }
      return CustomButton(
        text: 'Save',
        color: ColorManager.blue,
        fontColor: ColorManager.white,
        padding: EdgeInsets.zero,
        onTap: () => bloc.saveTask(context),
      );
    });
  }
}
