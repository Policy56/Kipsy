import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_tasks_repository.dart';

class UpdateTaskUSeCase
    implements UseCase<TaskOfListEntity, TaskOfListesParams> {
  final ShowTasksOfListesRepository _repository;
  const UpdateTaskUSeCase(this._repository);

  @override
  Future<Either<Failure, TaskOfListEntity>> call(TaskOfListesParams params) {
    return _repository.updateTask(params.taskOfListesEntity!);
  }
}
