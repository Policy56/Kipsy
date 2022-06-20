import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';

abstract class AddHouseRepository {
  Future<Either<Failure, HouseEntity>> addHouse(HouseEntity houseEntity);
}
