import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_house/domain/repositiory/add_existing_house_repository.dart';

class AddExistingHouseUseCase extends UseCase<void, AddExistingHouseParam> {
  final AddExistingHouseRepository _repository;
  AddExistingHouseUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(AddExistingHouseParam params) {
    return _repository.addExistingHouse(params.shareCode);
  }
}
