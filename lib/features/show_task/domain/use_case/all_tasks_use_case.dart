import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_tasks_repository.dart';

class AllTasksUseCase implements UseCase<List<TaskOfListEntity>, NoParams> {
  final ShowTasksOfListesRepository _repository;
  const AllTasksUseCase(this._repository);

  @override
  Future<Either<Failure, List<TaskOfListEntity>>> call(NoParams params) {
    return _repository.getAllTasks();
  }
}
