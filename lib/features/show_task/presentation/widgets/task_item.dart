import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/core/widget/custom_dismissable_pane_with_dialog.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(this.task, {Key? key}) : super(key: key);
  final TaskOfListEntity task;

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowHousesBloc>();
    return Slidable(
      key: ValueKey(task.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: CustomDismissiblePaneWithDialog(
          onDismissedFct: () => homeBloc.deleteTask(task),
          itemToDelete: task.titre ?? "",
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) async {
              //(BuildContext? context) => homeBloc.deleteTask(task);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: ColorManager.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => homeBloc.goToTaskDetail(context, task),
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
              BlocBuilder<ShowHousesBloc, ShowHouseState>(
                  builder: (BuildContext context, ShowHouseState state) =>
                      InkWell(
                        onTap: () => homeBloc.setTaskDone(task),
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
                      )),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.titre ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          /*Text(
                            TimeFormat.instance
                                .formatDate(dayNameWithTime, task.dateTime!),
                            style: const TextStyle(color: Colors.grey),
                          ),*/
                        ],
                      ),
                    ),
                    Expanded(
                      flex: (task.unite != "" || task.quantite != 0) ? 1 : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            (task.unite != null || task.quantite != null)
                                ? ((task.quantite != null && task.quantite! > 0)
                                        ? task.quantite!.toString()
                                        : "") +
                                    ((task.unite != null) ? task.unite! : "")
                                : "",
                            /*+
                                        ((task.unite != null)
                                            ? "task.unite!.toString()"
                                            : "")*/

                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Text(
                            task.description ?? "",
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
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
