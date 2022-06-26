import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/features/add_house/domain/use_case/add_existing_house_use_case.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_existing_house_state.dart';
import 'package:kipsy/features/add_house/presentation/model/house_toast_model.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class AddExistingHouseBloc extends Cubit<AddExistingHouseState> {
  final AddExistingHouseUseCase addExistingHouseUseCase;

  AddExistingHouseBloc(this.addExistingHouseUseCase)
      : super(AddExistingHouseEmpty());

  TextEditingController titleController = TextEditingController();

  bool get validateInputs => titleController.text.isEmpty;

  void saveExistingHouse(BuildContext context) async {
    if (validateInputs) {
      showToast(context, HouseToastModel.addHouseWarning);
      return;
    }

    emit(AddExistingHouseLoading());
    (await addExistingHouseUseCase
            .call(AddExistingHouseParam(titleController.text)))
        .fold((error) => emit(AddExistingHouseError(error.msg)),
            (house) => emit(AddExistingHouseLoad()));
  }

  void clearControllers() {
    titleController.clear();
  }

  void showToast(BuildContext context, HouseToastModel toastModel) {
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
