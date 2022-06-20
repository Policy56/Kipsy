import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

class TaskOfListModel extends TaskOfListEntity {
  TaskOfListModel(
      {required int views,
      String? description,
      String? list,
      DateTime? dateTime,
      bool? isDone,
      String? id,
      String? titre,
      int? quantite})
      : super(
            dateTime: dateTime,
            description: description,
            isDone: isDone,
            id: id,
            views: views,
            titre: titre,
            list: list);

  factory TaskOfListModel.fromJson(Map<String, dynamic> json) =>
      TaskOfListModel(
        titre: json['titre'],
        dateTime: json['dateTime'],
        description: json['description'],
        views: json['views'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'description': description,
        'id': id,
        'dateTime': dateTime,
        'isDone': isDone,
        'views': views,
      };
}
