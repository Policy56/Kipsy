import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_houses_repository.dart';

class DeleteHouseUseCase implements UseCase<HouseEntity, HouseParams> {
  final ShowHouseRepository _repository;
  const DeleteHouseUseCase(this._repository);

  @override
  Future<Either<Failure, HouseEntity>> call(HouseParams params) {
    return _repository.deleteHouse(params.houseEntity!);
  }
}
