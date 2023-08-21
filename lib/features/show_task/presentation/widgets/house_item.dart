import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/core/widget/custom_dismissable_pane_with_dialog.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';

class HouseItem extends StatelessWidget {
  const HouseItem(this.house, {Key? key}) : super(key: key);
  final HouseEntity house;

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowHousesBloc>();
    return Slidable(
      key: ValueKey(house.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: CustomDismissiblePaneWithDialog(
          onDismissedFct: () => homeBloc.deleteHouse(house),
          itemToDelete: house.titre ?? "",
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) async {
              //  await askToDeleteDismiss(homeBloc).show(context);
            },
            backgroundColor: ColorManager.red,
            foregroundColor: ColorManager.white,
            icon: Icons.delete,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),

        /*dismissible:
            DismissiblePane(onDismissed: () => homeBloc.shareHouse(house)),*/
        children: [
          SlidableAction(
            onPressed: (BuildContext? context) =>
                homeBloc.shareHouse(house, context!),
            backgroundColor: ColorManager.blue,
            foregroundColor: ColorManager.white,
            icon: Icons.share,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => homeBloc.goToListsOfHouse(context, house),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: ThemeManager.isDark(context)
                  ? Colors.black
                  : ColorManager.white,
              boxShadow: ThemeManager.isDark(context)
                  ? []
                  : [
                      BoxShadow(
                          color: Colors.grey[100]!,
                          offset: const Offset(0, 6),
                          blurRadius: 8,
                          spreadRadius: 1),
                    ]),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      house.titre ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Text(
                      house.shareCode ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    /* Text(
                      TimeFormat.instance.formatDate(
                          dayNameWithTime, DateTime.parse(house.dateTime!)),
                      style: const TextStyle(color: Colors.grey),
                    ),*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
