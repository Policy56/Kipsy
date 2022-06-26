import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';

abstract class AddExistingHouseRepository {
  Future<Either<Failure, void>> addExistingHouse(String shareCode);
}
