import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/show_task/data/data_source/show_houses_local_data_source.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_houses_repository.dart';

class ShowHouseRepositoryImpl implements ShowHouseRepository {
  final ShowHouseLocalDataSource _localSource;
  const ShowHouseRepositoryImpl(this._localSource);

  @override
  Future<Either<Failure, List<HouseEntity>>> getAllHouse() async {
    final result = await _localSource.getAllHouse();
    if (result != null) {
      return Right(result);
    } else {
      return const Left(CacheFailure(errorGetHouses));
    }
  }

  @override
  Future<Either<Failure, HouseEntity>> deleteHouse(HouseEntity house) async {
    try {
      final result = await _localSource.deleteHouse(house);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorRemoveHouse));
    }
  }

  @override
  Future<Either<Failure, HouseEntity>> updateHouse(HouseEntity house) async {
    try {
      final result = await _localSource.updateHouse(house);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure(errorUpdateHouse));
    }
  }
}

const String errorGetHouses = 'Error in get houses';
const String errorRemoveHouse = 'Error in remove house';
const String errorUpdateHouse = 'Error in update house';
