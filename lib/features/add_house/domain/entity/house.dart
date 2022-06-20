import 'package:equatable/equatable.dart';

class HouseEntity extends Equatable {
  String? id;
  final String? titre;
  final String? share_code;
  DateTime? dateTime;

  HouseEntity({this.titre, this.share_code, required this.id, this.dateTime});

  @override
  List<Object?> get props => [
        titre,
        share_code,
      ];
}
