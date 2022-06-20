import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kipsy/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/data/repository/add_task_repository_impl.dart';
import 'package:kipsy/features/add_task/domain/repositiory/add_task_repository.dart';

class MockAddTaskLocalDataSource extends Mock
    implements AddTasksLocalDataSource {}

void main() {
  MockAddTaskLocalDataSource? _localSource;
  AddTaskRepository? _repository;

  setUp(() {
    _localSource = MockAddTaskLocalDataSource();
    _repository = AddTaskRepositoryImpl(localSource: _localSource);
  });

  final tTaskOfListModel = TaskOfListModel(
      titre: '', dateTime: null, description: '', isDone: false, views: 0);

  test('should return [TaskOfListModel] when everything work fine', () async {
    //arrange
    when(() => _localSource!.addTask(tTaskOfListModel))
        .thenAnswer((_) async => tTaskOfListModel);
    //act
    final result = await _repository!.addTask(tTaskOfListModel);
    //assert
    expect(result, equals(Right(tTaskOfListModel)));
  });
}
