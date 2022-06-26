import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/dependency_container.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_existing_house_bloc.dart';
import 'package:kipsy/features/add_house/presentation/bloc/add_existing_house_state.dart';
import 'package:kipsy/features/add_house/presentation/model/house_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/widgets/custom_text_field.dart';
import 'package:kipsy/features/add_task/presentation/widgets/page_header.dart';
import 'package:kipsy/features/add_task/presentation/widgets/swipe_line.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';

class AddExistingHouse extends StatelessWidget {
  const AddExistingHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddExistingHouseBloc(sl()),
      child: const AddExistingHouseView(),
    );
  }
}

class AddExistingHouseView extends StatelessWidget {
  const AddExistingHouseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addExistingHouseBloc = context.read<AddExistingHouseBloc>();

    return WillPopScope(
      onWillPop: () async {
        addExistingHouseBloc.goBack(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.blue,
          leading: IconButton(
              onPressed: () => addExistingHouseBloc.goBack(context),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        backgroundColor: ColorManager.blue,
        body: PageHeader(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            children: [
              const SwipeLine(),
              CustomTextField(
                title: 'Add Existing Group',
                controller: addExistingHouseBloc.titleController,
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
    AddExistingHouseBloc bloc = context.read<AddExistingHouseBloc>();
    return BlocConsumer<AddExistingHouseBloc, AddExistingHouseState>(
        listener: (BuildContext context, AddExistingHouseState state) {
      if (state is AddExistingHouseLoad) {
        bloc.clearControllers();
        bloc.showToast(context, HouseToastModel.addExistingHouseSuccess);
      } else if (state is AddExistingHouseError) {
        bloc.showToast(context, HouseToastModel.addExistingHouseError);
      }
    }, builder: (BuildContext context, AddExistingHouseState state) {
      if (state is AddExistingHouseLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AddExistingHouseError) {
        return Center(child: Text(state.msg ?? ''));
      }
      return CustomButton(
        text: 'Save',
        color: ColorManager.blue,
        fontColor: Colors.white,
        padding: EdgeInsets.zero,
        onTap: () => bloc.saveExistingHouse(context),
      );
    });
  }
}
