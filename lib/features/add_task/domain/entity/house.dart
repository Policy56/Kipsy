import 'package:equatable/equatable.dart';

class HouseEntity extends Equatable {
  final String id;
  final String? titre;
  final String? shareCode;

  const HouseEntity({this.titre, this.shareCode, required this.id});

  @override
  List<Object?> get props => [
        titre,
        shareCode,
      ];
}
