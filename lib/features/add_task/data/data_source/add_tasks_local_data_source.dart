import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';

abstract class AddTasksLocalDataSource {
  Future<TaskOfListModel> addTask(TaskOfListModel task);
}

class AddTasksLocalDataSourceImpl implements AddTasksLocalDataSource {
  final DbService _dbService;
  const AddTasksLocalDataSourceImpl(this._dbService);

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
}
