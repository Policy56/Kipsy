import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_tasks_repository.dart';

class GetTaskOfListUseCase
    implements UseCase<List<TaskOfListEntity>, ListesOfHouseParams> {
  final ShowTasksOfListesRepository _repository;
  const GetTaskOfListUseCase(this._repository);

  @override
  Future<Either<Failure, List<TaskOfListEntity>>> call(
      ListesOfHouseParams params) {
    return _repository.getTaskOfList(params.listesOfHouseEntity!);
  }
}
