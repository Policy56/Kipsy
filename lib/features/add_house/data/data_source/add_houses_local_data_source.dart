import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_house/data/model/house_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      List<String>? savedItems = prefs.getStringList('house');
      savedItems ??= [];

      savedItems.add(house.shareCode!);
      await prefs.setStringList('house', savedItems);

      return house;
    } catch (e) {
      throw CacheException();
    }
  }
}
