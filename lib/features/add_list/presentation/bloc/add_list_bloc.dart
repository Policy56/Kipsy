import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_list/data/model/listes_of_house_model.dart';
import 'package:kipsy/features/add_list/domain/use_case/add_list_use_case.dart';
import 'package:kipsy/features/add_list/presentation/bloc/add_list_state.dart';
import 'package:kipsy/features/add_list/presentation/model/list_toast_model.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/use_case/use_case.dart';

class AddListBloc extends Cubit<AddListState> {
  final AddListUseCase addListUseCase;
  late HouseEntity house;

  AddListBloc(this.addListUseCase) : super(AddListEmpty());

  TextEditingController titleController = TextEditingController();

  ListOfHouseModel get _list => ListOfHouseModel(
      titre: titleController.text, dateTime: DateTime.now(), house: house.id);

  bool get validateInputs => titleController.text.isEmpty;

  void saveList(BuildContext context) async {
    if (validateInputs) {
      showToast(context, ListToastModel.addListWarning);
      return;
    }

    emit(AddListLoading());
    (await addListUseCase.call(AddListParam(_list))).fold(
        (error) => emit(AddListError(error.msg)),
        (list) => emit(AddListLoad(list: list)));
  }

  void clearControllers() {
    titleController.clear();
  }

  void showToast(BuildContext context, ListToastModel toastModel) {
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
