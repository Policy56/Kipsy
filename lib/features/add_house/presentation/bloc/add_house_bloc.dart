import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/features/add_house/data/model/house_model.dart';
import 'package:kipsy/features/add_house/domain/use_case/add_house_use_case.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_house_state.dart';
import 'package:kipsy/features/add_house/presentation/model/house_toast_model.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/use_case/use_case.dart';

class AddHouseBloc extends Cubit<AddHouseState> {
  final AddHouseUseCase addHouseUseCase;

  AddHouseBloc(this.addHouseUseCase) : super(AddHouseEmpty());

  TextEditingController titleController = TextEditingController();

  HouseModel get _house => HouseModel(
        titre: titleController.text,
        share_code: generateRandomString(
            15), //generation ici d'un random share Code de 15 lettres
        dateTime: DateTime.now(),
      );

  bool get validateInputs => titleController.text.isEmpty;

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(
        len, (index) => r.nextInt(25) + 65)); // Char entre 65 et 90 A-Z
  }

  void saveHouse(BuildContext context) async {
    if (validateInputs) {
      showToast(context, HouseToastModel.addHouseWarning);
      return;
    }

    emit(AddHouseLoading());
    (await addHouseUseCase.call(AddHouseParam(_house))).fold(
        (error) => emit(AddHouseError(error.msg)),
        (house) => emit(AddHouseLoad(house: house)));
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
