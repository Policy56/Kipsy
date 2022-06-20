import 'package:flutter/material.dart';
import 'package:kipsy/core/themes/colors_manager.dart';

class ListToastModel {
  final String? title, description;
  final Color? color;
  final IconData? icon;
  const ListToastModel({
    this.color,
    this.title,
    this.description,
    this.icon,
  });

  static ListToastModel get addListWarning => const ListToastModel(
      title: 'Warning',
      description: 'You should fill all inputs',
      icon: Icons.info,
      color: ColorManager.blue);

  static ListToastModel get addListSuccess => const ListToastModel(
      title: 'Success',
      description: 'Add List Successfully',
      icon: Icons.check,
      color: ColorManager.lightGreen);

  static ListToastModel get addListError => const ListToastModel(
      title: 'Error',
      description: 'Try again later..',
      icon: Icons.error,
      color: ColorManager.error);
}
