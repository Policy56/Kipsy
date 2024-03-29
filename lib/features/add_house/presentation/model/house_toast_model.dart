import 'package:flutter/material.dart';
import 'package:kipsy/core/themes/colors_manager.dart';

class HouseToastModel {
  final String? title, description;
  final Color? color;
  final IconData? icon;
  const HouseToastModel({
    this.color,
    this.title,
    this.description,
    this.icon,
  });

  static HouseToastModel get addHouseWarning => const HouseToastModel(
      title: 'Warning',
      description: 'You should fill all inputs',
      icon: Icons.info,
      color: ColorManager.blue);

  static HouseToastModel get addHouseSuccess => const HouseToastModel(
      title: 'Success',
      description: 'Add Group Successfully',
      icon: Icons.check,
      color: ColorManager.lightGreen);

  static HouseToastModel get addHouseError => const HouseToastModel(
      title: 'Error',
      description: 'Try again later..',
      icon: Icons.error,
      color: ColorManager.error);

  static HouseToastModel get addExistingHouseWarning => const HouseToastModel(
      title: 'Warning',
      description: 'You should fill all inputs',
      icon: Icons.info,
      color: ColorManager.blue);

  static HouseToastModel get addExistingHouseSuccess => const HouseToastModel(
      title: 'Success',
      description: 'Add Group Successfully',
      icon: Icons.check,
      color: ColorManager.lightGreen);

  static HouseToastModel get fullyCopiedToClipboard => const HouseToastModel(
      title: 'Success',
      description: 'Share code has been copied in Clipboard',
      icon: Icons.check,
      color: ColorManager.lightGreen);

  static HouseToastModel get addExistingHouseError => const HouseToastModel(
      title: 'Error',
      description: 'Try again later..',
      icon: Icons.error,
      color: ColorManager.error);
}
