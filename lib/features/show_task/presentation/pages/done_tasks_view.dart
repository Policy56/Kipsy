import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:kipsy/features/show_task/presentation/widgets/empty_state.dart';

import '../widgets/task_item.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowHousesBloc>();
    return BlocBuilder<ShowHousesBloc, ShowHouseState>(
        builder: (BuildContext context, ShowHouseState state) {
      return homeBloc.doneTasks!.isEmpty
          ? const EmptyState(
              imgName: 'no-done-tasks',
              text: 'No Done Tasks Yet',
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              itemBuilder: (BuildContext context, int index) =>
                  TaskItem(homeBloc.doneTasks![index]),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                indent: 12,
                endIndent: 12,
              ),
              itemCount: homeBloc.doneTasks!.length,
            );
    });
  }
}
