import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kipsy/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/data/repository/add_and_modify_task_repository_impl.dart';
import 'package:kipsy/features/add_task/domain/repositiory/add_and_modify_task_repository.dart';

class MockAddTaskLocalDataSource extends Mock
    implements AddAndModifyTasksLocalDataSource {}

void main() {
  MockAddTaskLocalDataSource? _localSource;
  AddAndModifyTaskRepository? _repository;

  setUp(() {
    _localSource = MockAddTaskLocalDataSource();
    _repository = AddAndModifyTaskRepositoryImpl(localSource: _localSource);
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
