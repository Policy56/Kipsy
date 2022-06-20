import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';
import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';

abstract class ShowListesOfHouseLocalDataSource {
  Future<List<ListesOfHouseEntity>?> getListOfHouse(HouseEntity house);

  Future<ListesOfHouseEntity> deleteListOfHouse(ListesOfHouseEntity list);

  Future<ListesOfHouseEntity> updateListOfHouse(ListesOfHouseEntity list);
}

class ShowListesOfHouseLocalDataSourceImpl
    implements ShowListesOfHouseLocalDataSource {
  final DbService _dbService;
  const ShowListesOfHouseLocalDataSourceImpl(this._dbService);

  @override
  Future<List<ListesOfHouseEntity>?> getListOfHouse(HouseEntity house) async {
    final result = await _dbService.allListOfHouse(house) ?? [];
    return result;
  }

  @override
  Future<ListesOfHouseEntity> deleteListOfHouse(
      ListesOfHouseEntity list) async {
    await _dbService.deleteItem(list.id);
    return list;
  }

  @override
  Future<ListesOfHouseEntity> updateListOfHouse(
      ListesOfHouseEntity list) async {
    ListesOfHouseEntity listOfHouseModel =
        ListesOfHouseEntity(id: list.id, titre: list.titre, house: list.house);
    await _dbService.updateListoOfHouse(listOfHouseModel);
    return list;
  }
}
