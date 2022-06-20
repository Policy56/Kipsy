import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_house/data/model/house_model.dart';

abstract class AddHousesLocalDataSource {
  Future<HouseModel> addHouse(HouseModel house);
}

class AddHousesLocalDataSourceImpl implements AddHousesLocalDataSource {
  final DbService _dbService;
  const AddHousesLocalDataSourceImpl(this._dbService);

  @override
  Future<HouseModel> addHouse(HouseModel house) async {
    try {
      String? houseId = await _dbService.createHouse(house);
      house.id = houseId;
      return house;
    } catch (e) {
      throw CacheException();
    }
  }
}
