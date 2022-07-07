import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/interface_fab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskFAB extends InterfaceFab {
  @override
  List<SpeedDialChild> getListButton(BuildContext context) {
    ShowHousesBloc homeBloc = context.read<ShowHousesBloc>();
    return [
      // TODO(ccl): ajouter d'autres types de taches
      /*
      SpeedDialChild(
        child: const Icon(
          Icons.add_task,
          color: Colors.white,
        ),
        label: 'Add image',
        backgroundColor: ColorManager.purple,
        onTap: () => homeBloc.goToAddTask(context),
      ),*/
      SpeedDialChild(
        child: const Icon(
          Icons.add_task,
          color: Colors.white,
        ),
        label: 'Add tasks',
        backgroundColor: ColorManager.purple,
        onTap: () => homeBloc.goToAddTask(context),
      ),
    ];
  }
}
