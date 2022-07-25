import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';

class CustomDismissiblePaneWithDialog extends StatelessWidget {
  CustomDismissiblePaneWithDialog(
      {Key? key, required this.onDismissedFct, required this.itemToDelete})
      : super(key: key);

  Function() onDismissedFct;

  String itemToDelete;

  @override
  Widget build(BuildContext context) {
    return DismissiblePane(
      onDismissed: onDismissedFct,
      confirmDismiss: () async {
        bool? result = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.transparent, width: 2)),
              title: const Text("Confirm"),
              content: Text("Are you sure you wish to delete $itemToDelete ?"),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        text: 'Delete',
                        color: ColorManager.red,
                        fontColor: ColorManager.white,
                        width: MediaQuery.of(context).size.width / 3,
                        onTap: () => Navigator.of(context).pop(true)),
                    CustomButton(
                        text: 'Cancel',
                        color: ColorManager.lightGrey,
                        width: MediaQuery.of(context).size.width / 3,
                        onTap: () => Navigator.of(context).pop(false)),
                  ],
                ),
              ],
            );
          },
        );
        return result != null ? Future.value(result) : Future.value(false);
      },
    );
  }
}
