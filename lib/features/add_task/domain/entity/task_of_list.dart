import 'package:equatable/equatable.dart';

class TaskOfListEntity extends Equatable {
  final String? titre, description, list;
  String? id;
  DateTime? dateTime;
  int? quantite;
  int views;
  bool? isDone;
  String? unite;
  TaskOfListEntity(
      {this.titre,
      this.description,
      this.dateTime,
      this.isDone,
      required this.views,
      this.id,
      this.list,
      this.quantite,
      this.unite});

  @override
  List<Object?> get props => [
        titre,
        description,
        dateTime,
        isDone,
        views,
        unite,
        quantite,
      ];
}
