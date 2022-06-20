import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/data/model/house_model.dart';
import 'package:kipsy/features/add_task/domain/entity/house.dart';

abstract class ShowHouseLocalDataSource {
  Future<List<HouseModel>?> getAllHouse();

  Future<HouseEntity> deleteHouse(HouseEntity house);

  Future<HouseEntity> updateHouse(HouseEntity house);
}

class ShowHouseLocalDataSourceImpl implements ShowHouseLocalDataSource {
  final DbService _dbService;
  const ShowHouseLocalDataSourceImpl(this._dbService);

  @override
  Future<List<HouseModel>?> getAllHouse() async {
    final result = await _dbService.allHouse() ?? [];
    return result;
  }

  @override
  Future<HouseEntity> deleteHouse(HouseEntity house) async {
    await _dbService.deleteItem(house.id);
    return house;
  }

  @override
  Future<HouseEntity> updateHouse(HouseEntity house) async {
    HouseModel houseModel = HouseModel(
        id: house.id, titre: house.titre, shareCode: house.shareCode);
    await _dbService.updateHouse(houseModel);
    return house;
  }
}
