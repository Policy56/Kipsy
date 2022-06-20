import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/show_task/domain/use_case/all_houses_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_listes_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_task_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/get_list_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/get_task_of_list_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/share_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_listes_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_task_use_case.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:kipsy/features/show_task/presentation/model/sub_tab_model.dart';
import 'package:kipsy/features/show_task/presentation/model/tab_model.dart';
import 'package:kipsy/features/show_task/presentation/pages/all_houses_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/all_listes_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/all_tasks_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/done_tasks_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/house_list_task_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/task_detail.dart';
import 'package:kipsy/features/show_task/presentation/pages/tasks_of_lists_view.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/home_fab.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/list_fab.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/tasks_fac.dart';
import '../../../add_task/presentation/pages/add_task_view.dart';

class ShowHousesBloc extends Cubit<ShowHouseState> {
  final AllHousesUseCase _allHousesUseCase;

  final ShareHouseUseCase _shareHouse;
  final DeleteHouseUseCase _deleteHouse;
  final UpdateHouseUseCase _updateHouse;
  final GetListOfHousesUseCase _getListOfHousesUseCase;
  final DeleteListesOfHouseUseCase _deleteListesOfHouse;
  final UpdateListesOfHouseUseCase _updateListesOfHouse;
  final UpdateTaskUSeCase _updateTask;
  final DeleteTaskUseCase _deleteTask;

  final GetTaskOfListUseCase _getTasksOfListUseCase;
  ShowHousesBloc(
    this._allHousesUseCase,
    this._deleteHouse,
    this._shareHouse,
    this._updateHouse,
    this._getListOfHousesUseCase,
    this._deleteListesOfHouse,
    this._updateListesOfHouse,
    this._getTasksOfListUseCase,
    this._updateTask,
    this._deleteTask,
  ) : super(HomeEmpty());

  int currentPage = 0;
  int currentSubPage = 0;

  List<TabModel> tabs = [
    const TabModel(id: 0, imgName: 'home', view: HouseListTaskView()),
    const TabModel(id: 1, imgName: 'home', view: AllTasks()),
    const TabModel(id: 2, imgName: 'check-mark', view: DoneTasks()),
  ];

  List<SubTabModel> subPage = [
    SubTabModel(
        id: 0, view: const AllHouses(), listFloatingActionButtonFab: HomeFAB()),
    SubTabModel(
        id: 1,
        view: const AllListesView(),
        listFloatingActionButtonFab: ListFAB()),
    SubTabModel(
        id: 2,
        view: const TasksOfListesView(),
        listFloatingActionButtonFab: TaskFAB()),
  ];

  List<HouseEntity> houses = [];
  List<ListesOfHouseEntity> listesOfHouse = [];
  List<TaskOfListEntity> tasksOfList = [];
  List<TaskOfListEntity>? mostVisitedTasks = [];
  List<TaskOfListEntity>? doneTasks = [];

  List<HouseEntity>? mostVisitedHouses = [];
  HouseEntity? selectedHouse;
  ListesOfHouseEntity? selectedListe;

  void changeActiveTab(int tabId) {
    currentPage = tabId;
    emit(HomeLoaded());
  }

  void setTaskDone(TaskOfListEntity task) {
    if (task.isDone == false) {
      task.isDone = true;
    } else {
      task.isDone = false;
    }
    updateLists();
    updateTask(task);
  }

  /*void goToAddHouse(BuildContext context) async {
    //Navigate
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => AddTask(
              liste: selectedListe!,
            ));
    await Navigator.of(context).push(materialPageRoute);
    //Update
    getAllHouses();
  }*/

  void goToListsOfHouse(BuildContext context, HouseEntity house) async {
    //house.views = (house.views ?? 0) + 1;
    //Navigate
    //final result = await navigateToListsOfHouse(context, house) as HouseEntity;
    emit(HomeLoading());
    currentSubPage = 1;
    selectedHouse = house;
    //Update
    await getListesOfHouses(house);
    emit(HomeLoaded());
    //update(result);
  }

  void goToTasksOfList(BuildContext context, ListesOfHouseEntity list) async {
    emit(HomeLoading());
    currentSubPage = 2;
    selectedListe = list;
    //Update
    await getTaskOfListes(list);
    emit(HomeLoaded());
  }

  void goToTaskDetail(BuildContext context, TaskOfListEntity task) async {
    task.views = task.views + 1;
    //Navigate
    final result =
        await navigateToTaskDetail(context, task) as TaskOfListEntity;
    //Update
    update(result);
  }

  void goToAddGroup(BuildContext context) async {
    //Navigate
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (_) => AddTask(liste: selectedListe!));
    await Navigator.of(context).push(materialPageRoute);
    //Update
    getAllHouses();
    //getAllTasks();
  }

  void goToAddList(BuildContext context) async {
    //Navigate
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => AddTask(
              liste: selectedListe!,
            ));
    await Navigator.of(context).push(materialPageRoute);
    //Update
    getListesOfHouses(selectedHouse!);
    //getAllTasks();
  }

  void goToAddTask(BuildContext context) async {
    //Navigate
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => AddTask(
              liste: selectedListe!,
            ));
    await Navigator.of(context).push(materialPageRoute);
    //Update
    getTaskOfListes(selectedListe!);
    //getAllTasks();
  }

  Future navigateToTaskDetail(
      BuildContext context, TaskOfListEntity task) async {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => const TaskDetailView(),
        settings: RouteSettings(arguments: task));
    return await Navigator.of(context).push(materialPageRoute);
  }

  /*Future navigateToListsOfHouse(BuildContext context, HouseEntity house) async {
    /*MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => const TaskDetailView(),
        settings: RouteSettings(arguments: task));
    return await Navigator.of(context).push(materialPageRoute);
    */
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (_) => const AllListesView(),
        settings: RouteSettings(arguments: house));
    return await Navigator.of(context).push(materialPageRoute);
  }*/

  void update(Equatable result) {
    updateLists();

    if (result is HouseEntity) {
      updateHouse(result);
    } else if (result is ListesOfHouseEntity) {
      updateListesOfHouse(result);
    } else if (result is TaskOfListEntity) {
      updateTask(result);
    }
  }

  void updateLists() {
    mostVisitedHouses = null;
    mostVisitedTasks = null;

    //Most Visited List
    mostVisitedTasks =
        tasksOfList.where((element) => element.views > 0).toList();
    mostVisitedTasks!.sort((b, a) => a.views.compareTo(b.views));

    //Most Visited House
    /*mostVisitedHouses =
        houses.where((element) => element.views > 0).toList();
    mostVisitedHouses!.sort((b, a) => a.views.compareTo(b.views));*/

    //Done Tasks
    doneTasks = tasksOfList.where((task) => task.isDone != 0).toList();
  }

  Future<void> updateTask(TaskOfListEntity task) async =>
      (await _updateTask(TaskOfListesParams(taskOfListesEntity: task))).fold(
        (e) => log(e.msg ?? ''),
        (task) => emit(HomeLoaded()),
      );

  Future<void> deleteTask(TaskOfListEntity task) async =>
      (await _deleteTask(TaskOfListesParams(taskOfListesEntity: task)))
          .fold((e) => log(e.msg ?? ''), (task) {
        tasksOfList.removeWhere((element) => element.id == task.id);
        updateLists();
        emit(HomeLoaded());
      });

  void goBack(BuildContext context) {
    currentSubPage = currentSubPage > 0 ? currentSubPage - 1 : currentSubPage;
    selectedHouse = null;
    getAllHouses();
    emit(HomeLoaded());
    //Navigator.pop(context);
  }

  //Working with Database
  Future<void> getAllHouses() async => (await _allHousesUseCase(NoParams()))
          .fold((e) => emit(HomeError(e.msg)), (houses) {
        this.houses = houses;
        updateLists();
        emit(HomeLoaded());
      });

  Future<void> getListesOfHouses(HouseEntity selectedHouse) async =>
      (await _getListOfHousesUseCase(HouseParams(houseEntity: selectedHouse)))
          .fold((e) => emit(HomeError(e.msg)), (listesOfHouse) {
        this.listesOfHouse = listesOfHouse;
        updateLists();
        emit(HomeLoaded());
      });

  Future<void> getTaskOfListes(ListesOfHouseEntity selectedlist) async =>
      (await _getTasksOfListUseCase(
              ListesOfHouseParams(listesOfHouseEntity: selectedlist)))
          .fold((e) => emit(HomeError(e.msg)), (tasksOfList) {
        this.tasksOfList = tasksOfList;
        updateLists();
        emit(HomeLoaded());
      });

  Future<void> deleteHouse(HouseEntity house) async =>
      (await _deleteHouse(HouseParams(houseEntity: house)))
          .fold((e) => log(e.msg ?? ''), (house) {
        houses.removeWhere((element) => element.id == house.id);
        updateLists();
        emit(HomeLoaded());
      });

  Future<void> shareHouse(HouseEntity house) async {
    await _shareHouse(HouseParams(houseEntity: house));

    // updateLists();
    // emit(HomeLoaded());
  }

  Future<void> updateHouse(HouseEntity house) async =>
      (await _updateHouse(HouseParams(houseEntity: house))).fold(
        (e) => log(e.msg ?? ''),
        (house) => emit(HomeLoaded()),
      );

  Future<void> deleteListesOfHouse(ListesOfHouseEntity list) async =>
      (await _deleteListesOfHouse(
              ListesOfHouseParams(listesOfHouseEntity: list)))
          .fold((e) => log(e.msg ?? ''), (list) {
        listesOfHouse.removeWhere((element) => element.id == list.id);
        updateLists();
        emit(HomeLoaded());
      });

  Future<void> updateListesOfHouse(ListesOfHouseEntity list) async =>
      (await _updateListesOfHouse(
              ListesOfHouseParams(listesOfHouseEntity: list)))
          .fold(
        (e) => log(e.msg ?? ''),
        (house) => emit(HomeLoaded()),
      );
}
