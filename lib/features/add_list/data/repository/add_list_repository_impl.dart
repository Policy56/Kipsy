import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_list/data/data_source/add_tasks_local_data_source.dart';
import 'package:kipsy/features/add_list/data/model/listes_of_house_model.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_list/domain/repositiory/add_list_repository.dart';

class AddListRepositoryImpl implements AddListRepository {
  final AddListsLocalDataSource? localSource;
  const AddListRepositoryImpl({this.localSource});

  @override
  Future<Either<Failure, ListesOfHouseEntity>> addList(
      ListesOfHouseEntity list) async {
    try {
      final houseParam = ListOfHouseModel(
        titre: list.titre,
        house: list.house,
        dateTime: DateTime.now(),
      );
      final listOfHouseModel = await localSource!.addList(houseParam);
      return Right(listOfHouseModel);
    } on CacheException {
      return const Left(CacheFailure(errorAddList));
    }
  }
}

const String errorAddList = 'Error when add new List';
