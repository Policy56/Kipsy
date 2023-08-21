import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_house/data/data_source/add_houses_local_data_source.dart';
import 'package:kipsy/features/add_house/data/model/house_model.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_house/domain/repositiory/add_house_repository.dart';

class AddHouseRepositoryImpl implements AddHouseRepository {
  final AddHousesLocalDataSource? localSource;
  const AddHouseRepositoryImpl({this.localSource});

  @override
  Future<Either<Failure, HouseEntity>> addHouse(HouseEntity houseEntity) async {
    try {
      final houseParam = HouseModel(
        titre: houseEntity.titre,
        shareCode: houseEntity.shareCode,
        dateTime: DateTime.now(),
      );
      final houseModel = await localSource!.addHouse(houseParam);
      return Right(houseModel);
    } on CacheException {
      return const Left(CacheFailure(errorAddHouse));
    }
  }
}

const String errorAddHouse = 'Error when add new group';
