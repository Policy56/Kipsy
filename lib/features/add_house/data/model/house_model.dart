import 'package:kipsy/features/add_house/domain/entity/house.dart';

class HouseModel extends HouseEntity {
  HouseModel({
    // ignore: non_constant_identifier_names
    share_code,
    String? id,
    String? titre,
    DateTime? dateTime,
  }) : super(share_code: share_code, id: id, titre: titre, dateTime: dateTime);
}
