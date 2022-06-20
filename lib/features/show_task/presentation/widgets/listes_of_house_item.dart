import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';

class ListesOfHouseItem extends StatelessWidget {
  const ListesOfHouseItem(this.listOfHouseEntity, {Key? key}) : super(key: key);
  final ListesOfHouseEntity listOfHouseEntity;

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowHousesBloc>();
    return Slidable(
      key: ValueKey(listOfHouseEntity.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
            onDismissed: () => homeBloc.deleteListesOfHouse(listOfHouseEntity)),
        children: [
          SlidableAction(
            onPressed: (BuildContext? context) =>
                homeBloc.deleteListesOfHouse(listOfHouseEntity),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => homeBloc.goToTasksOfList(context, listOfHouseEntity),
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
                      listOfHouseEntity.titre ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Text(
                      listOfHouseEntity.house ?? "",
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
