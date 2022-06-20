import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';

class ListOfHouseModel extends ListesOfHouseEntity {
  ListOfHouseModel({
    String? house,
    String? id,
    String? titre,
    DateTime? dateTime,
  }) : super(house: house, id: id, titre: titre, dateTime: dateTime);
}
