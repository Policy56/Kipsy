import 'package:flutter/material.dart';
import 'package:kipsy/core/themes/colors_manager.dart';

class TaskToastModel {
  final String? title, description;
  final Color? color;
  final IconData? icon;
  const TaskToastModel({
    this.color,
    this.title,
    this.description,
    this.icon,
  });

  static TaskToastModel get addTaskWarning => const TaskToastModel(
      title: 'Warning',
      description: 'You should fill all inputs',
      icon: Icons.info,
      color: ColorManager.blue);

  static TaskToastModel get addTaskSuccess => const TaskToastModel(
      title: 'Success',
      description: 'Add Task Successfully',
      icon: Icons.check,
      color: ColorManager.lightGreen);

  static TaskToastModel get addTaskError => const TaskToastModel(
      title: 'Error',
      description: 'Try again later..',
      icon: Icons.error,
      color: ColorManager.error);

  static TaskToastModel get editTaskNotImplemented => const TaskToastModel(
      title: '🚧 WIP 🚧',
      description: 'We are working on it !',
      icon: Icons.edit,
      color: ColorManager.orange);
}
