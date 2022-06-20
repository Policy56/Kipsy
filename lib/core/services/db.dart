import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kipsy/features/add_task/data/model/house_model.dart';
import 'package:kipsy/features/add_task/data/model/listes_of_house_model.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

class DbService {
  Future<String?> createTask(TaskOfListEntity task) async {
    // return db.insert('tasks', task.toJson());
    DocumentReference<Map<String, dynamic>> ref =
        await FirebaseFirestore.instance.collection("items").add({
      "titre": task.titre,
      "list": task.list,
      "description": task.description,
      "quantite": task.quantite,
      "done": task.isDone,
      "views": task.views,
      "dateTime": task.dateTime,
    });
    return ref.id;
  }

  Future<int> updateTask(TaskOfListEntity task) async {
    await FirebaseFirestore.instance.collection("items").doc(task.id).update({
      "done": task.isDone,
      "description": task.description,
      "titre": task.titre,
      "quantite": task.quantite,
      "views": task.views
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
    QuerySnapshot<Map<String, dynamic>> houseGet =
        await FirebaseFirestore.instance.collection('house').get();
    List<HouseModel> listHouse = houseGet.docs
        .map((doc) => HouseModel(
              id: doc.id,
              titre: doc.data()["titre"] ?? '',
              shareCode: doc.data()["share_code"] ?? '',
            ))
        .toList();

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
            ))
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
            isDone: doc.data()["done"] ?? false,
            views: doc.data()["views"] ?? 0,
            dateTime: doc.data()["dateTime"] != null &&
                    doc.data()["dateTime"] is Timestamp
                ? (doc.data()["dateTime"] as Timestamp).toDate()
                : DateTime.now()))
        .toList();

    return tasksOfList;
  }

  /*<List<TaskOfListModel>> allItems() async {
    QuerySnapshot<Map<String, dynamic>> itemsGet =
        await FirebaseFirestore.instance.collection('items').get();
    List listItems = itemsGet.docs.map((doc) => doc.data()).toList();

    TaskOfListModel TaskOfListModel1 = TaskOfListModel(
        dateTime: DateTime.now().toString(),
        description: "desc",
        id: 1.toString(),
        isDone: false,
        title: "titre",
        views: 2);
    /* HouseItem house =
                    HouseItem(titre: ds["titre"], nbOccupants: 2, id: ds.id);*/
    TaskOfListModel TaskOfListModel2 = TaskOfListModel(
        dateTime: DateTime.now().toString(),
        description: "desc",
        id: 1.toString(),
        isDone: false,
        title: "titre",
        views: 2);
    TaskOfListModel TaskOfListModel3 = TaskOfListModel(
        dateTime: DateTime.now().toString(),
        description: "desc",
        id: 1.toString(),
        isDone: false,
        title: "titre",
        views: 2);
    return [TaskOfListModel1, TaskOfListModel2, TaskOfListModel3];

    //return db.query('tasks');
  }*/

  Future<int> deleteItem(String id) async {
    // return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    return 1;
  }
}
