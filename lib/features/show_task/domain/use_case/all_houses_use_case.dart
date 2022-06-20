import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_houses_repository.dart';

class AllHousesUseCase implements UseCase<List<HouseEntity>, NoParams> {
  final ShowHouseRepository _repository;
  const AllHousesUseCase(this._repository);

  @override
  Future<Either<Failure, List<HouseEntity>>> call(NoParams params) {
    return _repository.getAllHouse();
  }
}
