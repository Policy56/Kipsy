import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_listes_of_house_repository.dart';

class DeleteListesOfHouseUseCase
    implements UseCase<ListesOfHouseEntity, ListesOfHouseParams> {
  final ShowListesOfHouseRepository _repository;
  const DeleteListesOfHouseUseCase(this._repository);

  @override
  Future<Either<Failure, ListesOfHouseEntity>> call(
      ListesOfHouseParams params) {
    return _repository.deleteListOfHouse(params.listesOfHouseEntity!);
  }
}
