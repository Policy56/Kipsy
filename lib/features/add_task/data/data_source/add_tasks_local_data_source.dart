import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';

abstract class AddAndModifyTasksLocalDataSource {
  Future<TaskOfListModel> addTask(TaskOfListModel task);
  Future<TaskOfListModel> modifyTask(TaskOfListModel task);
}

class AddAndModifyTasksLocalDataSourceImpl
    implements AddAndModifyTasksLocalDataSource {
  final DbService _dbService;
  const AddAndModifyTasksLocalDataSourceImpl(this._dbService);

  @override
  Future<TaskOfListModel> addTask(TaskOfListModel task) async {
    try {
      String? taskId = await _dbService.createTask(task);
      task.id = taskId;
      return task;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<TaskOfListModel> modifyTask(TaskOfListModel task) async {
    try {
      await _dbService.updateTask(task);
      return task;
    } catch (e) {
      throw CacheException();
    }
  }
}
