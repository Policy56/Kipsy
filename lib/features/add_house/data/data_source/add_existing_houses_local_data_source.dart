import 'package:kipsy/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AddExistingHousesLocalDataSource {
  Future<void> addExistingHouse(String shareCode);
}

class AddExistingHousesLocalDataSourceImpl
    implements AddExistingHousesLocalDataSource {
  const AddExistingHousesLocalDataSourceImpl();

  @override
  Future<void> addExistingHouse(String shareCode) async {
    try {
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      List<String>? savedItems = prefs.getStringList('house');
      savedItems ??= [];
      savedItems.add(shareCode);
      await prefs.setStringList('house', savedItems);
    } catch (e) {
      throw CacheException();
    }
  }
}
