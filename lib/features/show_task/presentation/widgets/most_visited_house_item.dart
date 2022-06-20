import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';

class MostVisitedHouseItem extends StatelessWidget {
  const MostVisitedHouseItem(this.house, {Key? key}) : super(key: key);
  final HouseEntity house;

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<ShowHousesBloc>();
    return InkWell(
      onTap: () => homeBloc.goToListsOfHouse(context, house),
      child: Container(
        width: 120,
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
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    color: ColorManager.blue,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Image.asset(
                          'assets/images/graph.png',
                          scale: 2,
                        ),
                        left: 0,
                        top: 20,
                      ),
                      Positioned(
                        child: Image.asset(
                          'assets/images/graph.png',
                          scale: 2,
                        ),
                        right: 0,
                        bottom: 20,
                      ),
                      Positioned(
                          bottom: 12,
                          left: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                house.titre ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                house.shareCode ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/view.png',
                    color: Colors.grey[400],
                    scale: 5,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "house.views TODO".toString(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
