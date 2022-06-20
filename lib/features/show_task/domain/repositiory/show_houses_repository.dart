import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';

abstract class ShowHouseRepository {
  Future<Either<Failure, List<HouseEntity>>> getAllHouse();

  Future<Either<Failure, HouseEntity>> deleteHouse(HouseEntity task);

  Future<Either<Failure, HouseEntity>> updateHouse(HouseEntity task);
}
