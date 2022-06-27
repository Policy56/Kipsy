import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_house/presentation/model/house_toast_model.dart';
import 'package:kipsy/features/add_house/presentation/pages/add_existing_house_view.dart';
import 'package:kipsy/features/add_house/presentation/pages/add_house_view.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_list/presentation/pages/add_list_view.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/presentation/pages/add_task_view.dart';
import 'package:kipsy/features/show_task/domain/use_case/all_houses_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_listes_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_task_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/get_list_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/get_task_of_list_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_listes_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_task_use_case.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_states.dart';
import 'package:kipsy/features/show_task/presentation/model/sub_tab_model.dart';
import 'package:kipsy/features/show_task/presentation/model/tab_model.dart';
import 'package:kipsy/features/show_task/presentation/pages/all_houses_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/all_listes_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/done_tasks_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/house_list_task_view.dart';
import 'package:kipsy/features/show_task/presentation/pages/task_detail.dart';
import 'package:kipsy/features/show_task/presentation/pages/tasks_of_lists_view.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/home_fab.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/list_fab.dart';
import 'package:kipsy/features/show_task/presentation/widgets/floating_action_button/tasks_fac.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowHousesBloc extends Cubit<ShowHouseState> {
  final AllHousesUseCase _allHousesUseCase;

  //final ShareHouseUseCase _shareHouse;
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
    //this._shareHouse,
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
    //const TabModel(id: 1, imgName: 'home', view: AllTasks()),
    const TabModel(id: 1, imgName: 'check-mark', view: DoneTasks()),
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
        MaterialPageRoute(builder: (_) => const AddHouse());
    await Navigator.of(context).push(materialPageRoute);
    //Update
    getAllHouses();
    //getAllTasks();
  }

  void goToAddExistingGroup(BuildContext context) async {
    //Navigate
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (_) => const AddExistingHouse());
    await Navigator.of(context).push(materialPageRoute);
    //Update
    getAllHouses();
    //getAllTasks();
  }

  void goToAddList(BuildContext context) async {
    if (selectedHouse != null) {
      //Navigate
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
          builder: (_) => AddList(
                houseEntity: selectedHouse!,
              ));
      await Navigator.of(context).push(materialPageRoute);

      //Update
      getListesOfHouses(selectedHouse!);
      //getAllTasks();
    }
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
    doneTasks = tasksOfList
        .where((task) => (task.isDone != null && task.isDone != false))
        .toList();
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
    if (currentSubPage == 0) {
      selectedHouse = null;
    }
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

  Future<void> shareHouse(HouseEntity house, BuildContext context) async {
    //await _shareHouse(HouseParams(houseEntity: house));

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.transparent, width: 2)),
          title: const Text("Share code"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: QrImage(
                  data: house.share_code ?? "",
                  version: QrVersions.auto,

                  //size: MediaQuery.of(context).size.width
                  size: 200.0,
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      child: const Center(
                        child: Text(
                          "Uh oh! Something went wrong...",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                child: Text(house.share_code ?? ""),
                onLongPress: () async {
                  await Clipboard.setData(
                      ClipboardData(text: house.share_code));
                  showToast(context, HouseToastModel.fullyCopiedToClipboard);
                },
              ),
            ],
          ),
          actions: <Widget>[
            CustomButton(
                text: 'Share',
                color: ColorManager.lightGrey,
                width: MediaQuery.of(context).size.width / 3,
                onTap: () => null //Navigator.of(context).pop(false)),
                )
          ],
        );
      },
    );
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

  void showToast(BuildContext context, HouseToastModel toastModel) {
    MotionToast(
      icon: toastModel.icon!,
      title: Text(toastModel.title ?? '', style: testStyle),
      description: Text(
        toastModel.description ?? '',
        style: testStyle,
      ),
      position: MotionToastPosition.bottom,
      animationType: AnimationType.fromBottom,
      primaryColor: toastModel.color!,
    ).show(context);
  }

  TextStyle get testStyle => const TextStyle(color: ColorManager.greyColor);
}
