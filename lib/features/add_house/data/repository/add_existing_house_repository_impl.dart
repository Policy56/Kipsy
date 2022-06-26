import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_house/data/data_source/add_existing_houses_local_data_source.dart';
import 'package:kipsy/features/add_house/domain/repositiory/add_existing_house_repository.dart';

class AddExistingHouseRepositoryImpl implements AddExistingHouseRepository {
  final AddExistingHousesLocalDataSource? localSource;
  const AddExistingHouseRepositoryImpl({this.localSource});

  @override
  Future<Either<Failure, void>> addExistingHouse(String shareCode) async {
    try {
      final houseModel = await localSource!.addExistingHouse(shareCode);
      return Right(houseModel);
    } on CacheException {
      return const Left(CacheFailure(errorAddExistingHouse));
    }
  }
}

const String errorAddExistingHouse = 'Error when add existing House';
