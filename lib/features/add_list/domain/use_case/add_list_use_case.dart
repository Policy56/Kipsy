import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_list/domain/repositiory/add_list_repository.dart';

class AddListUseCase extends UseCase<ListesOfHouseEntity, AddListParam> {
  final AddListRepository _repository;
  AddListUseCase(this._repository);

  @override
  Future<Either<Failure, ListesOfHouseEntity>> call(AddListParam params) {
    return _repository.addList(params.listesOfHouseEntity!);
  }
}
