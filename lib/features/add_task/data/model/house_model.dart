import 'package:kipsy/features/add_task/domain/entity/house.dart';

class HouseModel extends HouseEntity {
  const HouseModel({
    String? shareCode,
    required String id,
    String? titre,
  }) : super(shareCode: shareCode, id: id, titre: titre);
}
