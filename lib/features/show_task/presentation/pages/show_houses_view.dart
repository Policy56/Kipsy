import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:kipsy/features/show_task/presentation/widgets/mode_switcher.dart';

class ShowHousesView extends StatelessWidget {
  const ShowHousesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShowHousesBloc houseBloc = context.read<ShowHousesBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<ShowHousesBloc, ShowHouseState>(
          builder: (BuildContext context, ShowHouseState state) {
            return (houseBloc.currentSubPage != 0 && houseBloc.currentPage == 0)
                ? IconButton(
                    color: ThemeManager.isDark(context)
                        ? ColorManager.lightGrey
                        : Colors.black,
                    onPressed: () => houseBloc.goBack(context),
                    icon: const Icon(Icons.arrow_back_ios))
                : Container();
          },
        ),
        actions: const [ModeSwitcher()],
      ),
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.85),
        child: BlocBuilder<ShowHousesBloc, ShowHouseState>(
          builder: (BuildContext context, ShowHouseState state) {
            if (state is HomeLoaded &&
                houseBloc.subPage[houseBloc.currentSubPage]
                    .listFloatingActionButtonFab
                    .isNotEmptyList(context) &&
                houseBloc.currentPage == 0) {
              return SpeedDial(
                  icon: Icons.add,
                  activeIcon: Icons.add,
                  backgroundColor: ColorManager.purple,
                  useRotationAnimation: true,
                  animationCurve: Curves.elasticInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  foregroundColor: ColorManager.lightGrey,
                  animationAngle: pi,
                  elevation: 5.0,
                  children: houseBloc.subPage[houseBloc.currentSubPage]
                      .listFloatingActionButtonFab
                      .getListButton(context));
            } else {
              return Container();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ShowHousesBloc, ShowHouseState>(
              builder: (BuildContext context, ShowHouseState state) {
                if (state is HomeLoaded) {
                  return houseBloc.tabs[houseBloc.currentPage].view!;
                } else if (state is HomeError) {
                  return Center(child: Text(state.msg ?? ''));
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const BottomTabs()
        ],
      ),
    );
  }
}

class BottomTabs extends StatelessWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShowHousesBloc homeBloc = context.read<ShowHousesBloc>();
    return BlocBuilder<ShowHousesBloc, ShowHouseState>(
        builder: (BuildContext context, ShowHouseState state) => Container(
              height: 60,
              color: ThemeManager.isDark(context) ? Colors.black : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: homeBloc.tabs
                    .map((e) => Expanded(
                            child: InkWell(
                          onTap: () => homeBloc.changeActiveTab(e.id!),
                          child: Image.asset(
                            'assets/images/' + e.imgName! + '.png',
                            scale: 20,
                            color: e.id == homeBloc.currentPage
                                ? ThemeManager.isDark(context)
                                    ? Colors.white
                                    : Colors.black
                                : ThemeManager.isDark(context)
                                    ? Colors.grey[600]
                                    : Colors.grey[300],
                          ),
                        )))
                    .toList(),
              ),
            ));
  }
}
