import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';

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
        dismissible: DismissiblePane(
          onDismissed: () => homeBloc.deleteHouse(house),
          confirmDismiss: () async {
            bool? result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                          color: Colors.transparent, width: 2)),
                  title: const Text("Confirm"),
                  content:
                      Text("Are you sure you wish to delete ${house.titre} ?"),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            text: 'Delete',
                            color: ColorManager.red,
                            fontColor: Colors.white,
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
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) async {
              //  await askToDeleteDismiss(homeBloc).show(context);
            },
            backgroundColor: ColorManager.red,
            foregroundColor: Colors.white,
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
            onPressed: (BuildContext? context) => homeBloc.shareHouse(house),
            backgroundColor: ColorManager.blue,
            foregroundColor: Colors.white,
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
              color: ThemeManager.isDark(context) ? Colors.black : Colors.white,
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
              /*BlocBuilder<ShowHouseBloc, ShowHouseState>(
                  builder: (BuildContext context, ShowHouseState state) => InkWell(
                        onTap: () => null,//homeBloc.setTaskDone(task),
                        child: Container(
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: task.isDone == true
                                  ? Colors.green.shade300
                                  : Colors.grey[100]!),
                          child: CircleAvatar(
                            backgroundColor: task.isDone == true
                                ? Colors.green
                                : Colors.grey[200],
                            child: task.isDone == true
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      )),*/
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
                      house.share_code ?? "",
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
