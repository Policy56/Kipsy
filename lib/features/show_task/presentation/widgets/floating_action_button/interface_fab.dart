import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

abstract class InterfaceFab {
  List<SpeedDialChild> getListButton(BuildContext context);

  bool isNotEmptyList(BuildContext context) =>
      getListButton(context).isNotEmpty;
}
