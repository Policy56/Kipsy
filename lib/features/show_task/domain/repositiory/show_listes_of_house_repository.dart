import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';

abstract class ShowListesOfHouseRepository {
  Future<Either<Failure, List<ListesOfHouseEntity>>> getListOfHouse(
      HouseEntity house);

  Future<Either<Failure, ListesOfHouseEntity>> deleteListOfHouse(
      ListesOfHouseEntity list);

  Future<Either<Failure, ListesOfHouseEntity>> updateListOfHouse(
      ListesOfHouseEntity list);
}
