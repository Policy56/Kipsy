import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kipsy/features/add_house/data/model/house_model.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_list/data/model/listes_of_house_model.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbService {
  Future<String?> createTask(TaskOfListEntity task) async {
    DocumentReference<Map<String, dynamic>> ref =
        await FirebaseFirestore.instance.collection("items").add({
      "titre": task.titre,
      "list": task.list,
      "description": task.description,
      "quantite": task.quantite,
      "done": task.isDone,
      "views": task.views,
      "dateTime": task.dateTime,
      "unite": task.unite,
    });
    return ref.id;
  }

  Future<String?> createList(ListesOfHouseEntity list) async {
    DocumentReference<Map<String, dynamic>> ref =
        await FirebaseFirestore.instance.collection("list").add({
      "titre": list.titre,
      "house": list.house,
      "dateTime": list.dateTime,
      "type": list.type,
    });
    return ref.id;
  }

  Future<String?> createHouse(HouseEntity house) async {
    DocumentReference<Map<String, dynamic>> ref =
        await FirebaseFirestore.instance.collection("house").add({
      "titre": house.titre,
      "shareCode": house.shareCode,
      "dateTime": house.dateTime,
    });
    return ref.id;
  }

  Future<int> updateTask(TaskOfListEntity task) async {
    await FirebaseFirestore.instance.collection("items").doc(task.id).update({
      "titre": task.titre,
      "list": task.list,
      "description": task.description,
      "quantite": task.quantite,
      "done": task.isDone,
      "views": task.views,
      "dateTime": task.dateTime,
      "unite": task.unite,
    });
    return 1;
  }

  Future<int> updateHouse(HouseEntity house) async {
    await FirebaseFirestore.instance.collection("house").doc(house.id).update({
      "titre": house.titre,
    });
    return 1;
  }

  Future<int> updateListoOfHouse(ListesOfHouseEntity list) async {
    await FirebaseFirestore.instance.collection("house").doc(list.id).update({
      "titre": list.titre,
    });
    return 1;
  }

  Future<List<HouseModel>?> allHouse() async {
    List<HouseModel>? listHouse;
    final prefs = await SharedPreferences.getInstance();

    List<String>? savedItems = prefs.getStringList('house');

    savedItems ??= [];

    if (savedItems.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> houseGet = await FirebaseFirestore
          .instance
          .collection('house')
          .where('shareCode', whereIn: savedItems)
          .get();
      listHouse = houseGet.docs
          .map((doc) => HouseModel(
                id: doc.id,
                titre: doc.data()["titre"] ?? '',
                shareCode: doc.data()["shareCode"] ?? '',
                dateTime: doc.data()["dateTime"] != null &&
                        doc.data()["dateTime"] is Timestamp
                    ? (doc.data()["dateTime"] as Timestamp).toDate()
                    : DateTime.now(),
              ))
          .toList();
    }
    return listHouse;
  }

  Future<List<ListOfHouseModel>?> allListOfHouse(HouseEntity house) async {
    QuerySnapshot<Map<String, dynamic>> listOfhouseGet = await FirebaseFirestore
        .instance
        .collection('list')
        .where('house', isEqualTo: house.id)
        .get();

    List<ListOfHouseModel> listOfHouse = listOfhouseGet.docs
        .map((doc) => ListOfHouseModel(
            id: doc.id,
            titre: doc.data()["titre"] ?? '',
            house: house.id,
            type: doc.data()["type"] ?? '',
            dateTime: doc.data()["dateTime"] != null &&
                    doc.data()["dateTime"] is Timestamp
                ? (doc.data()["dateTime"] as Timestamp).toDate()
                : DateTime.now()))
        .toList();

    return listOfHouse;
  }

  Future<List<TaskOfListModel>?> allTasksOfList(
      {ListesOfHouseEntity? list}) async {
    QuerySnapshot<Map<String, dynamic>> listOfhouseGet;

    if (list == null) {
      listOfhouseGet =
          await FirebaseFirestore.instance.collection('items').get();
    } else {
      listOfhouseGet = await FirebaseFirestore.instance
          .collection('items')
          .where('list', isEqualTo: list.id)
          .get();
    }

    List<TaskOfListModel> tasksOfList = listOfhouseGet.docs
        .map((doc) => TaskOfListModel(
            id: doc.id,
            titre: doc.data()["titre"] ?? '',
            list: doc.data()["list"] ?? '',
            description: doc.data()["description"] ?? "",
            quantite: doc.data()["quantite"] ?? 0,
            unite: doc.data()["unite"] ?? "",
            isDone: doc.data()["done"] ?? false,
            views: doc.data()["views"] ?? 0,
            dateTime: doc.data()["dateTime"] != null &&
                    doc.data()["dateTime"] is Timestamp
                ? (doc.data()["dateTime"] as Timestamp).toDate()
                : DateTime.now()))
        .toList();

    return tasksOfList;
  }

  Future<String> getTitleDoneTask({ListesOfHouseEntity? list}) async {
    String returnValue = "";

    List<TaskOfListModel>? listTask = await allTasksOfList(list: list);

    if (listTask != null && listTask.isNotEmpty) {
      int nbDone = 0;

      for (var element in listTask) {
        if (element.isDone == true) {
          nbDone++;
        }
      }
      returnValue = "$nbDone / ${listTask.length}";
    } else {
      // TODO(ccl) : trad
      returnValue = "Empty";
    }

    return returnValue;
  }

  /// ***
  /// DELETE TASKS
  ///
  ///
  ///
  ///
  ///

  Future<void> deleteHouse(HouseEntity houseEntity) async {
    final prefs = await SharedPreferences.getInstance();
    //await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

    List<String>? savedItems = prefs.getStringList('house');

    savedItems ??= [];

    if (savedItems.isNotEmpty) {
      savedItems.removeWhere((element) => element == houseEntity.shareCode);
    }
    savedItems;
    await prefs.setStringList('house', savedItems);

    // On ne supprime plus en base le group et les listes quand on supprime dans l'appli

    /*await FirebaseFirestore.instance
        .collection("house")
        .doc(houseEntity.id)
        .delete();

    List<ListOfHouseModel>? listOfHouse = await allListOfHouse(houseEntity);
    if (listOfHouse != null) {
      for (ListOfHouseModel list in listOfHouse) {
        await deleteListOfHouse(list);
      }
    }
    */
  }

  Future<void> deleteListOfHouse(ListesOfHouseEntity list) async {
    await FirebaseFirestore.instance.collection("list").doc(list.id).delete();

    List<TaskOfListModel>? listOfTask = await allTasksOfList(list: list);
    if (listOfTask != null) {
      for (TaskOfListModel task in listOfTask) {
        await deleteTasks(task);
      }
    }
  }

  Future<void> deleteTasks(TaskOfListEntity taskOfListEntity) async {
    await FirebaseFirestore.instance
        .collection("items")
        .doc(taskOfListEntity.id)
        .delete();
  }

  Future<TaskOfListModel> getTasks(TaskOfListEntity task) async {
    DocumentSnapshot<Map<String, dynamic>> taskGet;

    taskGet =
        await FirebaseFirestore.instance.collection('items').doc(task.id).get();
    TaskOfListModel taskOfListModel = TaskOfListModel(
        id: taskGet.id,
        titre: taskGet.data()!["titre"] ?? '',
        list: taskGet.data()!["list"] ?? '',
        description: taskGet.data()!["description"] ?? "",
        quantite: taskGet.data()!["quantite"] ?? 0,
        unite: taskGet.data()!["unite"] ?? "",
        isDone: taskGet.data()!["done"] ?? false,
        views: taskGet.data()!["views"] ?? 0,
        dateTime: taskGet.data()!["dateTime"] != null &&
                taskGet.data()!["dateTime"] is Timestamp
            ? (taskGet.data()!["dateTime"] as Timestamp).toDate()
            : DateTime.now());
    return taskOfListModel;
  }
}
