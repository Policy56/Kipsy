import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

abstract class AddTaskRepository {
  Future<Either<Failure, TaskOfListEntity>> addTask(TaskOfListEntity task);
}
