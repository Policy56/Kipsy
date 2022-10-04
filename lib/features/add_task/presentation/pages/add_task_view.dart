import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/dependency_container.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/presentation/bloc/add_modif_task_bloc.dart';
import 'package:kipsy/features/add_task/presentation/bloc/add_task_state.dart';
import 'package:kipsy/features/add_task/presentation/model/task_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/widgets/custom_text_field.dart';
import 'package:kipsy/features/add_task/presentation/widgets/page_header.dart';
import 'package:kipsy/features/add_task/presentation/widgets/swipe_line.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/new_task_fab.dart';
import 'package:kipsy/core/widget/custom_button.dart';

class AddTask extends StatelessWidget {
  ListesOfHouseEntity liste;

  AddTask({Key? key, required this.liste}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddAndModifyTaskBloc(AddOrModifyEnum.modeAdd, sl(), sl()),
      child: AddAndModifyTaskView(
        typeOfUseCase: AddOrModifyEnum.modeAdd,
        listeId: liste.id!,
        oldTask: null,
      ),
    );
  }
}

class ModifyTask extends StatelessWidget {
  String listeId;
  TaskOfListEntity oldTask;

  ModifyTask({Key? key, required this.listeId, required this.oldTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AddAndModifyTaskBloc(AddOrModifyEnum.modeModify, sl(), sl()),
      child: AddAndModifyTaskView(
        typeOfUseCase: AddOrModifyEnum.modeModify,
        listeId: listeId,
        oldTask: oldTask,
      ),
    );
  }
}

class AddAndModifyTaskView extends StatefulWidget {
  String listeId;
  TaskOfListEntity? oldTask;

  AddOrModifyEnum typeOfUseCase;
  AddAndModifyTaskView(
      {Key? key,
      required this.typeOfUseCase,
      required this.oldTask,
      required this.listeId})
      : super(key: key);

  @override
  State<AddAndModifyTaskView> createState() => _AddAndModifyTaskViewState();
}

class _AddAndModifyTaskViewState extends State<AddAndModifyTaskView> {
  List<Widget> customNewWidget = [];

  @override
  Widget build(BuildContext context) {
    final addTaskBloc = context.read<AddAndModifyTaskBloc>();

    if (widget.oldTask != null) {
      addTaskBloc.titleController.text = widget.oldTask!.titre ?? "";
      addTaskBloc.descriptionController.text =
          widget.oldTask!.description ?? "";
      addTaskBloc.uniteController.text = widget.oldTask!.unite ?? "";
      addTaskBloc.quantiteController.text = widget.oldTask!.quantite != null
          ? widget.oldTask!.quantite.toString()
          : '0';

      if (widget.oldTask!.unite != "" || widget.oldTask!.quantite != 0) {
        addTaskBloc.visibilityQteUnit = true;
      }

      addTaskBloc.oldId = widget.oldTask!.id;
    }

    addTaskBloc.listeId = widget.listeId;
    return WillPopScope(
      onWillPop: () async {
        addTaskBloc.goBack(context, false);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.blue,
            leading: IconButton(
                onPressed: () => addTaskBloc.goBack(context, false),
                icon: const Icon(Icons.arrow_back_ios),
                color: ThemeManager.isDark(context)
                    ? ColorManager.lightGrey
                    : ColorManager.lightGrey),
          ),
          backgroundColor: ColorManager.blue,
          floatingActionButton: Align(
            alignment: const Alignment(1, 0.85),
            child: BlocBuilder<AddAndModifyTaskBloc, AddAndModifyTaskState>(
              builder: (BuildContext context, AddAndModifyTaskState state) {
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
          body: BlocBuilder<AddAndModifyTaskBloc, AddAndModifyTaskState>(
              builder: (BuildContext context, AddAndModifyTaskState state) {
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
                  AddBtn(
                    typeOfUseCase: widget.typeOfUseCase,
                  )
                ],
              ),
            );
          })),
    );
  }

  Widget btnQuantiteEtUnite() {
    final addTaskBloc = context.read<AddAndModifyTaskBloc>();
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
              addTaskBloc.quantiteController.text = "";
              addTaskBloc.uniteController.text = "";
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
  AddBtn({Key? key, required this.typeOfUseCase}) : super(key: key);

  AddOrModifyEnum typeOfUseCase;

  @override
  Widget build(BuildContext context) {
    AddAndModifyTaskBloc bloc = context.read<AddAndModifyTaskBloc>();
    return BlocConsumer<AddAndModifyTaskBloc, AddAndModifyTaskState>(
        listener: (BuildContext context, AddAndModifyTaskState state) async {
      if (state is AddAndModifyTaskLoad) {
        bloc.clearControllers();
        if (Navigator.of(context).canPop() &&
            typeOfUseCase == AddOrModifyEnum.modeModify) {
          await Future<void>.delayed(const Duration(milliseconds: 200));

          bloc.goBack(context, true);
        }
        bloc.showToast(context, TaskToastModel.addTaskSuccess);
      } else if (state is AddAndModifyTaskError) {
        bloc.showToast(context, TaskToastModel.addTaskError);
      }
    }, builder: (BuildContext context, AddAndModifyTaskState state) {
      if (state is AddAndModifyTaskLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AddAndModifyTaskError) {
        return Center(child: Text(state.msg ?? ''));
      }
      return CustomButton(
        text: 'Save',
        color: ColorManager.blue,
        fontColor: ColorManager.white,
        padding: EdgeInsets.zero,
        onTap: () => bloc.saveTask(
          context,
        ),
      );
    });
  }
}
