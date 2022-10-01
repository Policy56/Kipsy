import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/domain/repositiory/add_and_modify_task_repository.dart';

class AddAndModifyTaskRepositoryImpl implements AddAndModifyTaskRepository {
  final AddAndModifyTasksLocalDataSource? localSource;
  const AddAndModifyTaskRepositoryImpl({this.localSource});

  @override
  Future<Either<Failure, TaskOfListEntity>> addTask(
      TaskOfListEntity task) async {
    try {
      final taskParam = TaskOfListModel(
          titre: task.titre,
          description: task.description,
          dateTime: task.dateTime,
          views: task.views,
          isDone: task.isDone,
          list: task.list,
          quantite: task.quantite,
          unite: task.unite);
      final taskOfListModel = await localSource!.addTask(taskParam);
      return Right(taskOfListModel);
    } on CacheException {
      return const Left(CacheFailure(errorAddTask));
    }
  }

  @override
  Future<Either<Failure, TaskOfListEntity>> modifyTask(
      TaskOfListEntity task) async {
    try {
      final taskParam = TaskOfListModel(
          titre: task.titre,
          description: task.description,
          dateTime: task.dateTime,
          views: task.views,
          isDone: task.isDone,
          list: task.list,
          quantite: task.quantite,
          unite: task.unite,
          id: task.id);
      final taskOfListModel = await localSource!.modifyTask(taskParam);
      return Right(taskOfListModel);
    } on CacheException {
      return const Left(CacheFailure(errorModifyTask));
    }
  }
}

const String errorAddTask = 'Error when add new Task';
const String errorModifyTask = 'Error when modify task';
