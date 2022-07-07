import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/presentation/model/task_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/widgets/page_header.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../../../core/themes/colors_manager.dart';
import '../../../add_task/presentation/widgets/swipe_line.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({Key? key}) : super(key: key);

  void showToast(BuildContext context, TaskToastModel toastModel) {
    MotionToast(
      icon: toastModel.icon!,
      title: Text(toastModel.title ?? '', style: testStyle),
      description: Text(
        toastModel.description ?? '',
        style: testStyle,
      ),
      position: MotionToastPosition.bottom,
      animationType: AnimationType.fromBottom,
      primaryColor: toastModel.color!,
    ).show(context);
  }

  TextStyle get testStyle => const TextStyle(color: ColorManager.greyColor);

  @override
  Widget build(BuildContext context) {
    TaskOfListEntity task =
        ModalRoute.of(context)!.settings.arguments as TaskOfListEntity;
    return WillPopScope(
      onWillPop: () async {
        goBack(context, task);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.pink,
          actions: const [
            /*
            // TODO(ccl): a ajouter la modification de taches
            IconButton(
                onPressed: () => showToast(
                    context,
                    TaskToastModel
                        .editTaskNotImplemented), //goBack(context, task),
                icon: const Icon(Icons.edit),
                color: ThemeManager.isDark(context)
                    ? ColorManager.lightGrey
                    : ColorManager.blue)*/
          ],
          leading: IconButton(
              onPressed: () => goBack(context, task),
              icon: const Icon(Icons.arrow_back_ios),
              color: ThemeManager.isDark(context)
                  ? ColorManager.lightGrey
                  : ColorManager.blue),
        ),
        backgroundColor: ColorManager.pink,
        body: PageHeader(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            children: [
              const SwipeLine(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.titre ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                    ),
                    TaskStatus(task)
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ((task.unite != null || task.quantite != null) &&
                      (task.unite != "" || task.quantite != 0))
                  ? Text(
                      (task.unite != null || task.quantite != null)
                          ? ((task.quantite != null && task.quantite! > 0)
                                  ? task.quantite!.toString()
                                  : "") +
                              ((task.unite != null) ? task.unite! : "")
                          : "",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    )
                  : Container(),
              ((task.unite != null || task.quantite != null) &&
                      (task.unite != "" || task.quantite != 0))
                  ? const SizedBox(
                      height: 20,
                    )
                  : Container(),
              Text(
                task.description ?? '',
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/view.png',
                    color: Colors.grey[400],
                    scale: 5,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    task.views.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goBack(BuildContext context, TaskOfListEntity task) =>
      Navigator.pop(context, task);
}

class TaskStatus extends StatelessWidget {
  const TaskStatus(this.task, {Key? key}) : super(key: key);
  final TaskOfListEntity task;

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<ShowHousesBloc>();
    return BlocBuilder<ShowHousesBloc, ShowHouseState>(
        builder: (BuildContext context, ShowHouseState state) => InkWell(
              onTap: () {
                homeCubit.setTaskDone(task);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: task.isDone == false
                        ? ThemeManager.isDark(context)
                            ? ColorManager.lightGrey.withAlpha(50)
                            : ColorManager.blue.withAlpha(50)
                        : ColorManager.lightGreen.withAlpha(50)),
                child: Center(
                  child: Text(
                    task.isDone == false
                        ? 'in progress'.toUpperCase()
                        : 'done'.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: task.isDone == false
                            ? ThemeManager.isDark(context)
                                ? ColorManager.lightGrey
                                : ColorManager.blue
                            : ColorManager.lightGreen),
                  ),
                ),
              ),
            ));
  }
}
