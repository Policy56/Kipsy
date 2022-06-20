import 'package:flutter/cupertino.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/interface_fab.dart';

class SubTabModel {
  final int? id;
  final Widget? view;
  final InterfaceFab listFloatingActionButtonFab;
  const SubTabModel(
      {this.id, this.view, required this.listFloatingActionButtonFab});
}
