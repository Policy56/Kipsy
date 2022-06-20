import 'package:kipsy/features/add_task/domain/entity/list_of_house.dart';

class ListOfHouseModel extends ListesOfHouseEntity {
  const ListOfHouseModel({
    String? house,
    required String id,
    String? titre,
  }) : super(house: house, id: id, titre: titre);
}
