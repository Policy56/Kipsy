import 'package:equatable/equatable.dart';

class ListesOfHouseEntity extends Equatable {
  String? id;
  final String? titre;
  final String? house;

  DateTime? dateTime;

  ListesOfHouseEntity(
      {this.titre, this.house, required this.id, this.dateTime});

  @override
  List<Object?> get props => [
        titre,
        house,
      ];
}
