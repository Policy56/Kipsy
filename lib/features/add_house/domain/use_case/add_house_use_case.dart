import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_house/domain/repositiory/add_house_repository.dart';

class AddHouseUseCase extends UseCase<HouseEntity, AddHouseParam> {
  final AddHouseRepository _repository;
  AddHouseUseCase(this._repository);

  @override
  Future<Either<Failure, HouseEntity>> call(AddHouseParam params) {
    return _repository.addHouse(params.houseEntity!);
  }
}
