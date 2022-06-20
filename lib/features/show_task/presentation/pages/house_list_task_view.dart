import 'package:flutter/material.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HouseListTaskView extends StatelessWidget {
  const HouseListTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final houseBloc = context.read<ShowHousesBloc>();
    return BlocBuilder<ShowHousesBloc, ShowHouseState>(
      builder: (BuildContext context, ShowHouseState state) {
        if (state is HomeLoaded) {
          return houseBloc.subPage[houseBloc.currentSubPage].view!;
        } else if (state is HomeError) {
          return Center(child: Text(state.msg ?? ''));
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
