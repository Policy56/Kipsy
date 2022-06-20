import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kipsy/core/themes/colors_manager.dart';

class HomeFAB {
  List<SpeedDialChild> getListButton() {
    return [
      SpeedDialChild(
        child: const Icon(
          Icons.group_add,
          color: Colors.white,
        ),
        label: 'Create group',
        backgroundColor: ColorManager.purple,
        onTap: () {/* Do someting */},
      ),
      SpeedDialChild(
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
        ),
        label: 'Add existing group',
        backgroundColor: ColorManager.purple,
        onTap: () {/* Do something */},
      ),
    ];
  }
}
