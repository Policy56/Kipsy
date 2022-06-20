import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

abstract class ShowTasksOfListesRepository {
  Future<Either<Failure, List<TaskOfListEntity>>> getAllTasks();

  Future<Either<Failure, List<TaskOfListEntity>>> getTaskOfList(
      ListesOfHouseEntity list);

  Future<Either<Failure, TaskOfListEntity>> deleteTask(TaskOfListEntity task);

  Future<Either<Failure, TaskOfListEntity>> updateTask(TaskOfListEntity task);
}
