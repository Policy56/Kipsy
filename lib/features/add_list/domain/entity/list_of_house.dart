import 'package:equatable/equatable.dart';

class ListesOfHouseEntity extends Equatable {
  String? id;
  final String? titre;
  final String? house;
  final String? type;
  DateTime? dateTime;

  ListesOfHouseEntity(
      {this.titre, this.house, required this.id, this.dateTime, this.type});

  @override
  List<Object?> get props => [titre, house, type];
}
