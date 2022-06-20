import 'package:equatable/equatable.dart';

class TaskOfListEntity extends Equatable {
  final String? titre, description, list;
  String? id;
  DateTime? dateTime;
  int? quantite;
  int views;
  bool? isDone;
  TaskOfListEntity(
      {this.titre,
      this.description,
      this.dateTime,
      this.isDone,
      required this.views,
      this.id,
      this.list,
      this.quantite});

  @override
  List<Object?> get props => [
        titre,
        description,
        dateTime,
        isDone,
        views,
      ];
}
