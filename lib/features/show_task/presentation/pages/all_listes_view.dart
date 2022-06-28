import 'package:flutter/material.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:kipsy/features/show_task/presentation/widgets/listes_of_house_item.dart';
import 'package:kipsy/features/show_task/presentation/widgets/most_visited_house_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/empty_state.dart';

class AllListesView extends StatelessWidget {
  const AllListesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowHousesBloc>();
    return BlocBuilder<ShowHousesBloc, ShowHouseState>(
        builder: (BuildContext context, ShowHouseState state) {
      return homeBloc.listesOfHouse.isEmpty
          ? const EmptyState(
              imgName: 'no-tasks',
              text: 'No List of this group Yet',
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              children: [
                if (homeBloc.mostVisitedHouses != null &&
                    homeBloc.mostVisitedHouses!.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Most Visited List of houses ',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) =>
                          MostVisitedHouseItem(
                              homeBloc.mostVisitedHouses![index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        indent: 12,
                        endIndent: 12,
                      ),
                      itemCount: homeBloc.mostVisitedHouses!.length,
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'All List of House ' +
                        ((homeBloc.selectedHouse != null &&
                                homeBloc.selectedHouse!.titre != null)
                            ? homeBloc.selectedHouse!.titre!
                            : ""),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) =>
                      ListesOfHouseItem(homeBloc.listesOfHouse[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    indent: 12,
                    endIndent: 12,
                  ),
                  itemCount: homeBloc.listesOfHouse.length,
                )
              ],
            );
    });
  }
}
