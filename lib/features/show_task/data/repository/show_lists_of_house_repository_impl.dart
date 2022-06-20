import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/show_task/data/data_source/show_listes_of_house_local_data_source.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_listes_of_house_repository.dart';

class ShowListesOfHouseRepositoryImpl implements ShowListesOfHouseRepository {
  final ShowListesOfHouseLocalDataSource _localSource;
  const ShowListesOfHouseRepositoryImpl(this._localSource);

  @override
  Future<Either<Failure, List<ListesOfHouseEntity>>> getListOfHouse(
      HouseEntity house) async {
    final result = await _localSource.getListOfHouse(house);
    if (result != null) {
      return Right(result);
    } else {
      return const Left(CacheFailure(errorGetListOfHouses));
    }
  }

  @override
  Future<Either<Failure, ListesOfHouseEntity>> deleteListOfHouse(
      ListesOfHouseEntity list) async {
    try {
      final result = await _localSource.deleteListOfHouse(list);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorRemoveListOfHouse));
    }
  }

  @override
  Future<Either<Failure, ListesOfHouseEntity>> updateListOfHouse(
      ListesOfHouseEntity list) async {
    try {
      final result = await _localSource.updateListOfHouse(list);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorUpdateListOfHouse));
    }
  }
}

const String errorGetListOfHouses = 'Error in get list of the house';
const String errorRemoveListOfHouse = 'Error in remove list of the house';
const String errorUpdateListOfHouse = 'Error in update list of the house';
