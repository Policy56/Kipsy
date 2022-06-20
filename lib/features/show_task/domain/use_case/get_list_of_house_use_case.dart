import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_listes_of_house_repository.dart';

class GetListOfHousesUseCase
    implements UseCase<List<ListesOfHouseEntity>, HouseParams> {
  final ShowListesOfHouseRepository _repository;
  const GetListOfHousesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ListesOfHouseEntity>>> call(HouseParams params) {
    return _repository.getListOfHouse(params.houseEntity!);
  }
}
