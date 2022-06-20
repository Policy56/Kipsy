import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

String ficture(String fileName) =>
    File('test/fixture/' + fileName).readAsStringSync();

void main() {
  final tTaskOfListModel = TaskOfListModel(
      titre: 'Title',
      description: 'test',
      dateTime: DateTime.now(),
      isDone: true,
      views: 1202);

  test('should [TaskOfListModel] equal [TaskOfListEntity] subclass', () {
    //arrange
    //act
    //assert
    expect(TaskOfListModel(views: 0), isA<TaskOfListEntity>());
  });

  test('should convert json to [TaskOfListModel]', () {
    //arrange
    //act
    final task = TaskOfListModel.fromJson(json.decode(ficture('task.json')));
    //assert
    expect(task, equals(tTaskOfListModel));
  });

  test('should convert model to json', () {
    //arrange
    final taskJson = json.decode(ficture('task.json'));
    //act
    final task = tTaskOfListModel.toJson();
    //assert
    expect(task, equals(taskJson));
  });
}
