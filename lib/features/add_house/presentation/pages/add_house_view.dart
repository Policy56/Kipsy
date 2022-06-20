import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/dependency_container.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_house_bloc.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_house_state.dart';
import 'package:kipsy/features/add_house/presentation/model/house_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/widgets/custom_text_field.dart';
import 'package:kipsy/features/add_task/presentation/widgets/page_header.dart';
import 'package:kipsy/features/add_task/presentation/widgets/swipe_line.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';

class AddHouse extends StatelessWidget {
  const AddHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddHouseBloc(sl()),
      child: const AddHouseView(),
    );
  }
}

class AddHouseView extends StatelessWidget {
  const AddHouseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addHouseBloc = context.read<AddHouseBloc>();

    return WillPopScope(
      onWillPop: () async {
        addHouseBloc.goBack(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.blue,
          leading: IconButton(
              onPressed: () => addHouseBloc.goBack(context),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        backgroundColor: ColorManager.blue,
        body: PageHeader(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            children: [
              const SwipeLine(),
              CustomTextField(
                title: 'New group',
                controller: addHouseBloc.titleController,
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
              const SizedBox(
                height: 40,
              ),
              const AddBtn()
            ],
          ),
        ),
      ),
    );
  }
}

class AddBtn extends StatelessWidget {
  const AddBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddHouseBloc bloc = context.read<AddHouseBloc>();
    return BlocConsumer<AddHouseBloc, AddHouseState>(
        listener: (BuildContext context, AddHouseState state) {
      if (state is AddHouseLoad) {
        bloc.clearControllers();
        bloc.showToast(context, HouseToastModel.addHouseSuccess);
      } else if (state is AddHouseError) {
        bloc.showToast(context, HouseToastModel.addHouseError);
      }
    }, builder: (BuildContext context, AddHouseState state) {
      if (state is AddHouseLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AddHouseError) {
        return Center(child: Text(state.msg ?? ''));
      }
      return CustomButton(
        text: 'Save',
        color: ColorManager.blue,
        fontColor: Colors.white,
        padding: EdgeInsets.zero,
        onTap: () => bloc.saveHouse(context),
      );
    });
  }
}
