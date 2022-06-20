import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/show_task/data/data_source/show_tasks_local_data_source.dart';
import 'package:kipsy/features/show_task/data/repository/show_tasks_repository_impl.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_tasks_repository.dart';

class MockHomeLocalDataSource extends Mock
    implements ShowTasksOfListesLocalDataSource {}

void main() {
  MockHomeLocalDataSource? _localSource;
  ShowTasksOfListesRepository? _repository;

  setUp(() {
    _localSource = MockHomeLocalDataSource();
    _repository = ShowTasksOfListesRepositoryImpl(_localSource!);
  });

  final tasks = [
    TaskOfListModel(
        titre: '', description: '', dateTime: null, isDone: false, views: 0),
    TaskOfListModel(
        titre: '', description: '', dateTime: null, isDone: false, views: 0),
    TaskOfListModel(
        titre: '', description: '', dateTime: null, isDone: false, views: 0),
  ];

  test('should call get all tasks when call show_task repository', () async {
    //arrange
    when(() => _localSource!.getAllTasks()).thenAnswer((_) async => tasks);
    //act
    await _repository!.getAllTasks();
    //assert
    verify(() => _localSource!.getAllTasks());
    verifyNoMoreInteractions(_localSource);
  });

  test(
      'should return right side [TasksList] when tasks list '
      'return successfully from local data source', () async {
    //arrange
    when(() => _localSource!.getAllTasks()).thenAnswer((_) async => tasks);
    //act
    final result = await _repository!.getAllTasks();
    //assert
    expect(result, equals(Right(tasks)));
  });

  test('should return left side [Failure] when tasks list is null', () async {
    //arrange
    when(() => _localSource!.getAllTasks()).thenAnswer((_) async => null);
    //act
    final result = await _repository!.getAllTasks();
    //assert
    expect(result, equals(const Left(CacheFailure(errorGetTasks))));
  });
}
