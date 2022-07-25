import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/interface_fab.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFAB extends InterfaceFab {
  @override
  List<SpeedDialChild> getListButton(BuildContext context) {
    ShowHousesBloc homeBloc = context.read<ShowHousesBloc>();
    return [
      SpeedDialChild(
        child: const Icon(
          Icons.group_add,
          color: ColorManager.white,
        ),
        label: 'Create group',
        backgroundColor: ColorManager.blue,
        onTap: () => homeBloc.goToAddGroup(context),
      ),
      SpeedDialChild(
        child: const Icon(
          Icons.qr_code_scanner,
          color: ColorManager.white,
        ),
        label: 'Add existing group',
        backgroundColor: ColorManager.blue,
        onTap: () => homeBloc.goToAddExistingGroup(context),
      ),
    ];
  }
}
