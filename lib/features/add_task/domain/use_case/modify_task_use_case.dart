import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/domain/repositiory/add_and_modify_task_repository.dart';

class ModifyTaskUseCase extends UseCase<TaskOfListEntity, AddTaskParam> {
  final AddAndModifyTaskRepository _repository;
  ModifyTaskUseCase(this._repository);

  @override
  Future<Either<Failure, TaskOfListEntity>> call(AddTaskParam params) {
    return _repository.modifyTask(params.taskOfListEntity!);
  }
}
