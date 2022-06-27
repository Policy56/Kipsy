import 'package:flutter/material.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:kipsy/features/show_task/presentation/widgets/house_item.dart';
import 'package:kipsy/features/show_task/presentation/widgets/most_visited_house_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/empty_state.dart';

class AllHouses extends StatelessWidget {
  const AllHouses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowHousesBloc>();
    return BlocBuilder<ShowHousesBloc, ShowHouseState>(
        builder: (BuildContext context, ShowHouseState state) {
      return homeBloc.houses.isEmpty
          ? const EmptyState(
              imgName: 'no-tasks',
              text: 'No House Yet',
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              children: [
                if (homeBloc.mostVisitedHouses != null &&
                    homeBloc.mostVisitedHouses!.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Most Visited Houses',
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'All Groups',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) =>
                      HouseItem(homeBloc.houses[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    indent: 12,
                    endIndent: 12,
                  ),
                  itemCount: homeBloc.houses.length,
                )
              ],
            );
    });
  }
}
