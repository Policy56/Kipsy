import 'package:equatable/equatable.dart';

class HouseEntity extends Equatable {
  String? id;
  String? titre;
  String? shareCode;
  DateTime? dateTime;

  HouseEntity({this.titre, this.shareCode, required this.id, this.dateTime});

  @override
  List<Object?> get props => [
        titre,
        shareCode,
      ];
}
