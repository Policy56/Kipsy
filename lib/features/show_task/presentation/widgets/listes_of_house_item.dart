import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/core/time/time_format.dart';
import 'package:kipsy/core/widget/custom_dismissable_pane_with_dialog.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
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
        dismissible: CustomDismissiblePaneWithDialog(
          onDismissedFct: () => homeBloc.deleteListesOfHouse(listOfHouseEntity),
          itemToDelete: listOfHouseEntity.titre ?? "",
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) async {
              //  homeBloc.deleteListesOfHouse(listOfHouseEntity),
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: ColorManager.white,
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
                                    color: ColorManager.white,
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Column(
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
                          TimeFormat.instance.formatDate(
                              dayNameWithTime, listOfHouseEntity.dateTime!),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                            future: DbService()
                                .getTitleDoneTask(list: listOfHouseEntity),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              Widget child;
                              if (snapshot.hasData) {
                                child = Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text('${snapshot.data}'),
                                );
                              } else {
                                child = Container();
                              }
                              return child;
                            }),
                      ],
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
