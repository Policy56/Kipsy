import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';

abstract class AddListRepository {
  Future<Either<Failure, ListesOfHouseEntity>> addList(
      ListesOfHouseEntity task);
}
