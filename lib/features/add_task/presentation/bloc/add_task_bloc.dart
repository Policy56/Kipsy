import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/domain/use_case/add_task_use_case.dart';
import 'package:kipsy/features/add_task/presentation/bloc/add_task_state.dart';
import '../model/toast_model.dart';

class AddTaskBloc extends Cubit<AddTaskState> {
  final AddTaskUseCase addTaskUseCase;
  late ListesOfHouseEntity liste;

  AddTaskBloc(this.addTaskUseCase) : super(AddTaskEmpty());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TaskOfListModel get _task => TaskOfListModel(
      titre: titleController.text,
      description: descriptionController.text,
      isDone: false,
      views: 0,
      dateTime: DateTime.now(),
      quantite: 0,
      list: liste.id);

  bool get validateInputs =>
      titleController.text.isEmpty || descriptionController.text.isEmpty;

  void saveTask(BuildContext context) async {
    if (validateInputs) {
      showToast(context, ToastModel.addTaskWarning);
      return;
    }

    emit(AddTaskLoading());
    (await addTaskUseCase.call(AddTaskParam(_task))).fold(
        (error) => emit(AddTaskError(error.msg)),
        (task) => emit(AddTaskLoad(task: task)));
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
  }

  void showToast(BuildContext context, ToastModel toastModel) {
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

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
