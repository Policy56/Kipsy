import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/domain/use_case/modify_task_use_case.dart';
import 'package:kipsy/features/add_task/presentation/model/task_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/pages/add_task_view.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/domain/use_case/add_task_use_case.dart';
import 'package:kipsy/features/add_task/presentation/bloc/add_task_state.dart';

enum AddOrModifyEnum {
  modeAdd,
  modeModify,
  modeCheckValue,
}

class AddAndModifyTaskBloc extends Cubit<AddAndModifyTaskState> {
  final AddTaskUseCase? addTaskUseCase;
  final ModifyTaskUseCase? modifyTaskUseCase;
  final AddOrModifyEnum typeOfUseCase;

  late String? listeId;
  String? oldId;

  AddAndModifyTaskBloc(
      this.typeOfUseCase, this.addTaskUseCase, this.modifyTaskUseCase)
      : super(AddAndModifyTaskEmpty());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantiteController = TextEditingController();
  TextEditingController uniteController = TextEditingController();

  bool? _visibilityQteUnit = false;

  bool? get visibilityQteUnit => _visibilityQteUnit;
  TaskOfListEntity? selectedTask;

  set visibilityQteUnit(bool? value) {
    _visibilityQteUnit = value;

    if (value == true) {
      emit(AddAndModifyTypeTask());
    } else if (value == false) {
      emit(RemoveTypeTask());
    }
  }

  TaskOfListModel get _task => TaskOfListModel(
      titre: titleController.text,
      description: descriptionController.text,
      isDone: false,
      views: 0,
      dateTime: DateTime.now(),
      quantite: int.tryParse(quantiteController.text) ?? 0,
      unite: uniteController.text,
      list: listeId,
      id: oldId);

  bool get validateInputs =>
      titleController.text.isEmpty /*|| descriptionController.text.isEmpty*/;

  void saveTask(BuildContext context) async {
    if (validateInputs) {
      showToast(context, TaskToastModel.addTaskWarning);
      return;
    }

    emit(AddAndModifyTaskLoading());
    if (typeOfUseCase == AddOrModifyEnum.modeAdd && addTaskUseCase != null) {
      (await addTaskUseCase!.call(AddTaskParam(_task))).fold(
          (error) => emit(AddAndModifyTaskError(error.msg)),
          (task) => emit(AddAndModifyTaskLoad(task: task)));
    } else if (typeOfUseCase == AddOrModifyEnum.modeModify &&
        modifyTaskUseCase != null) {
      (await modifyTaskUseCase!.call(AddTaskParam(_task))).fold(
          (error) => emit(AddAndModifyTaskError(error.msg)),
          (task) => emit(AddAndModifyTaskLoad(task: task)));
    }
  }

  Future<void> goToModifyTask(
      BuildContext context, TaskOfListEntity oldTask) async {
    //Navigate
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => ModifyTask(
              listeId: oldTask.list!,
              oldTask: oldTask,
            ),
        settings: RouteSettings(arguments: oldTask));
    await Navigator.of(context).push(materialPageRoute);

    emit(AddAndModifyTaskLoading());
    selectedTask = await DbService().getTasks(oldTask);
    emit(AddAndModifyTaskLoad());

    //getAllTasks();
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    quantiteController.clear();
    uniteController.clear();
  }

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

  void goBack(BuildContext context, bool hasBeenModified) {
    Navigator.pop(context);
  }
}
