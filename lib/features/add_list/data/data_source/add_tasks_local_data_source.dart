import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_list/data/model/listes_of_house_model.dart';

abstract class AddListsLocalDataSource {
  Future<ListOfHouseModel> addList(ListOfHouseModel task);
}

class AddListsLocalDataSourceImpl implements AddListsLocalDataSource {
  final DbService _dbService;
  const AddListsLocalDataSourceImpl(this._dbService);

  @override
  Future<ListOfHouseModel> addList(ListOfHouseModel list) async {
    try {
      String? listId = await _dbService.createList(list);
      list.id = listId;
      return list;
    } catch (e) {
      throw CacheException();
    }
  }
}
