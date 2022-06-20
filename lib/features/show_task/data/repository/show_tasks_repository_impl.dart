import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/show_task/data/data_source/show_tasks_local_data_source.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_tasks_repository.dart';

class ShowTasksOfListesRepositoryImpl implements ShowTasksOfListesRepository {
  final ShowTasksOfListesLocalDataSource _localSource;
  const ShowTasksOfListesRepositoryImpl(this._localSource);

  @override
  Future<Either<Failure, List<TaskOfListEntity>>> getAllTasks() async {
    final result = await _localSource.getAllTasks();
    if (result != null) {
      return Right(result);
    } else {
      return const Left(CacheFailure(errorGetTasks));
    }
  }

  @override
  Future<Either<Failure, List<TaskOfListEntity>>> getTaskOfList(
      ListesOfHouseEntity list) async {
    final result = await _localSource.getTasksOfList(list);
    if (result != null) {
      return Right(result);
    } else {
      return const Left(CacheFailure(errorGetTasks));
    }
  }

  @override
  Future<Either<Failure, TaskOfListEntity>> deleteTask(
      TaskOfListEntity task) async {
    try {
      final result = await _localSource.deleteTask(task);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorRemoveTask));
    }
  }

  @override
  Future<Either<Failure, TaskOfListEntity>> updateTask(
      TaskOfListEntity task) async {
    try {
      final result = await _localSource.updateTask(task);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorUpdateTask));
    }
  }
}

const String errorGetTasks = 'Error in get tasks';
const String errorRemoveTask = 'Error in remove task';
const String errorUpdateTask = 'Error in update task';
