import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/dependency_container.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_list/presentation/bloc/add_list_bloc.dart';
import 'package:kipsy/features/add_list/presentation/bloc/add_list_state.dart';
import 'package:kipsy/features/add_list/presentation/model/list_toast_model.dart';
import 'package:kipsy/features/add_task/presentation/widgets/custom_text_field.dart';
import 'package:kipsy/features/add_task/presentation/widgets/page_header.dart';
import 'package:kipsy/features/add_task/presentation/widgets/swipe_line.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';

class AddList extends StatelessWidget {
  HouseEntity houseEntity;

  AddList({Key? key, required this.houseEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddListBloc(sl()),
      child: AddListView(
        house: houseEntity,
      ),
    );
  }
}

class AddListView extends StatelessWidget {
  HouseEntity house;
  AddListView({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addListBloc = context.read<AddListBloc>();

    addListBloc.house = house;
    return WillPopScope(
      onWillPop: () async {
        addListBloc.goBack(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.blue,
          leading: IconButton(
              onPressed: () => addListBloc.goBack(context),
              icon: const Icon(Icons.arrow_back_ios),
              color: ThemeManager.isDark(context)
                  ? ColorManager.lightGrey
                  : ColorManager.blue),
        ),
        backgroundColor: ColorManager.blue,
        body: PageHeader(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            children: [
              const SwipeLine(),
              CustomTextField(
                title: 'New list',
                controller: addListBloc.titleController,
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
    AddListBloc addListBloc = context.read<AddListBloc>();
    return BlocConsumer<AddListBloc, AddListState>(
        listener: (BuildContext context, AddListState state) async {
      if (state is AddListLoad) {
        addListBloc.clearControllers();
        if (Navigator.of(context).canPop()) {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          addListBloc.goBack(context);
        }
        addListBloc.showToast(context, ListToastModel.addListSuccess);
      } else if (state is AddListError) {
        addListBloc.showToast(context, ListToastModel.addListError);
      }
    }, builder: (BuildContext context, AddListState state) {
      if (state is AddListLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AddListError) {
        return Center(child: Text(state.msg ?? ''));
      }
      return CustomButton(
        text: 'Save',
        color: ColorManager.blue,
        fontColor: Colors.white,
        padding: EdgeInsets.zero,
        onTap: () => addListBloc.saveList(context),
      );
    });
  }
}
