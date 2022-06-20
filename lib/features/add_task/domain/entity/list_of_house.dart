import 'package:equatable/equatable.dart';

class ListesOfHouseEntity extends Equatable {
  final String id;
  final String? titre;
  final String? house;

  const ListesOfHouseEntity({this.titre, this.house, required this.id});

  @override
  List<Object?> get props => [
        titre,
        house,
      ];
}
