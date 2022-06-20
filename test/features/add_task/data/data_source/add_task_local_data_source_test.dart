import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kipsy/core/error/exceptions.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';

class MockDatabase extends Mock implements DbService {}

void main() {
  MockDatabase? databaseService;
  AddTasksLocalDataSource? _localSource;

  setUp(() {
    databaseService = MockDatabase();
    _localSource = AddTasksLocalDataSourceImpl(databaseService!);
  });

  final tTaskOfListModel = TaskOfListModel(
      titre: '', description: '', dateTime: null, isDone: false, views: 0);

  test('should call add task when call method', () async {
    //arrange
    when(() => databaseService!.createTask(tTaskOfListModel))
        .thenAnswer((_) async => "0");
    //act
    await _localSource!.addTask(tTaskOfListModel);
    //assert
    verify(() => databaseService!.createTask(tTaskOfListModel));
    verifyNoMoreInteractions(databaseService);
  });

  test('should return [TaskOfListModel] when stored success in database',
      () async {
    //arrange
    when(() => databaseService!.createTask(tTaskOfListModel))
        .thenAnswer((_) async => "1");
    //act
    final result = await _localSource!.addTask(tTaskOfListModel);
    //assert
    expect(result, equals(tTaskOfListModel));
  });

  test('should return [CacheException] when throw error', () async {
    //arrange
    when(() => databaseService!.createTask(tTaskOfListModel))
        .thenThrow(Exception());
    //act
    final result = _localSource!.addTask(tTaskOfListModel);
    //assert
    expect(() => result, throwsA(const TypeMatcher<CacheException>()));
  });
}
