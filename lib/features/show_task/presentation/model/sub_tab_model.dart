import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SubTabModel {
  final int? id;
  final String? imgName;
  final Widget? view;
  final List<SpeedDialChild> listFloatingActionButton;
  const SubTabModel(
      {this.id,
      this.imgName,
      this.view,
      required this.listFloatingActionButton});
}
