/*import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';
import 'package:kipsy/features/add_task/domain/entity/listOfHouse.dart';
import 'package:kipsy/features/add_task/domain/entity/taskOfList.dart';
import 'package:kipsy/features/show_task/data/data_source/show_listes_of_house_local_data_source.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_listes_of_house_repository.dart';

class ShowTasksOfListesRepositoryImpl implements ShowTasksOfListesRepository {
  final ShowTasksOfListesLocalDataSource _localSource;
  const ShowTasksOfListesRepositoryImpl(this._localSource);

  @override
  Future<Either<Failure, List<TaskOfListEntity>>> getListOfHouse(
      HouseEntity house) async {
    final result = await _localSource.getListOfHouse(house);
    if (result != null) {
      return Right(result);
    } else {
      return const Left(CacheFailure(errorGetTasksOfListes));
    }
  }

  @override
  Future<Either<Failure, TasksOfListesEntity>> deleteListOfHouse(
      TasksOfListesEntity list) async {
    try {
      final result = await _localSource.deleteListOfHouse(list);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorRemoveTasksOfListes));
    }
  }

  @override
  Future<Either<Failure, TasksOfListesEntity>> updateListOfHouse(
      TasksOfListesEntity list) async {
    try {
      final result = await _localSource.updateListOfHouse(list);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorUpdateTasksOfListes));
    }
  }
}

const String errorGetTasksOfListes = 'Error in get tasks of the list';
const String errorRemoveTasksOfListes = 'Error in remove task of the list';
const String errorUpdateTasksOfListes = 'Error in update task of the list';
*/