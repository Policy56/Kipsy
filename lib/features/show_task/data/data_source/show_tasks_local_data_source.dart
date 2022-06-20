import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

abstract class ShowTasksOfListesLocalDataSource {
  Future<List<TaskOfListModel>?> getAllTasks();

  Future<List<TaskOfListModel>?> getTasksOfList(ListesOfHouseEntity list);

  Future<TaskOfListEntity> deleteTask(TaskOfListEntity task);

  Future<TaskOfListEntity> updateTask(TaskOfListEntity task);
}

class ShowTaskLocalDataSourceImpl implements ShowTasksOfListesLocalDataSource {
  final DbService _dbService;
  const ShowTaskLocalDataSourceImpl(this._dbService);

  @override
  Future<List<TaskOfListModel>?> getAllTasks() async {
    final result = await _dbService.allTasksOfList();
    return result;
    //return List<TaskOfListModel>.from(result.map((item) => TaskOfListModel.fromJson(item)));
  }

  @override
  Future<List<TaskOfListModel>?> getTasksOfList(
      ListesOfHouseEntity list) async {
    final result = await _dbService.allTasksOfList(list: list);
    return result;
  }

  @override
  Future<TaskOfListEntity> deleteTask(TaskOfListEntity task) async {
    await _dbService.deleteItem(task.id!.toString());
    return task;
  }

  @override
  Future<TaskOfListEntity> updateTask(TaskOfListEntity task) async {
    TaskOfListModel taskOfListModel = TaskOfListModel(
        id: task.id,
        isDone: task.isDone,
        titre: task.titre,
        dateTime: task.dateTime,
        description: task.description,
        views: task.views);
    await _dbService.updateTask(taskOfListModel);
    return task;
  }
}
