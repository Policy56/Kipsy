import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/features/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/interface_fab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskFAB extends InterfaceFab {
  @override
  List<SpeedDialChild> getListButton(BuildContext context) {
    AddTaskBloc addTaskBloc = context.read<AddTaskBloc>();
    return [
      // TODO(ccl): ajouter d'autres types de taches
      /*
      SpeedDialChild(
        child: const Icon(
          Icons.add_task,
          color: ColorManager.white,
        ),
        label: 'Add image',
        backgroundColor: ColorManager.blue,
        onTap: () => homeBloc.goToAddTask(context),
      ),*/
      SpeedDialChild(
          child: const Icon(
            Icons.add_task,
            color: ColorManager.white,
          ),
          label: 'Add tasks',
          backgroundColor: ColorManager.blue,
          onTap: () => null //homeBloc.goToAddTask(context),
          ),
    ];
  }
}
