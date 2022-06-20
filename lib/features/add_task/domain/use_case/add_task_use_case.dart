import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/domain/repositiory/add_task_repository.dart';

class AddTaskUseCase extends UseCase<TaskOfListEntity, AddTaskParam> {
  final AddTaskRepository _repository;
  AddTaskUseCase(this._repository);

  @override
  Future<Either<Failure, TaskOfListEntity>> call(AddTaskParam params) {
    return _repository.addTask(params.taskOfListEntity!);
  }
}
