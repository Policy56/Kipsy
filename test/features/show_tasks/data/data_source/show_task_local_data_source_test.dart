import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/show_task/data/data_source/show_tasks_local_data_source.dart';

class MockDBService extends Mock implements DbService {}

void main() {
  MockDBService? _dbService;
  ShowTasksOfListesLocalDataSource? localSource;

  setUp(() {
    _dbService = MockDBService();
    localSource = ShowTaskLocalDataSourceImpl(_dbService!);
  });

  final tasks = [
    TaskOfListModel(
            titre: '', dateTime: null, description: '', views: 0, isDone: false)
        .toJson(),
    TaskOfListModel(
            titre: '', dateTime: null, description: '', views: 0, isDone: false)
        .toJson(),
    TaskOfListModel(
            titre: '', dateTime: null, description: '', views: 0, isDone: false)
        .toJson(),
  ];
  final task = TaskOfListModel(
      titre: '',
      dateTime: null,
      description: '',
      views: 0,
      isDone: false,
      id: 0.toString());

  /*test('should call get tasks form database when call function', () async {
    //arrange
    when(() => _dbService!.allItems()).thenAnswer((_) async => tasks);
    //act
    await localSource!.getAllTasks();
    //assert
    verify(() => _dbService!.allItems());
    verifyNoMoreInteractions(_dbService);
  });*/

  /*test('should list in db is empty when db return null for any reason',
      () async {
    //arrange
    when(() => _dbService!.allItems()).thenAnswer((_) async => null);
    //act
    final result = await localSource!.getAllTasks();
    //assert
    expect(result, equals([]));
  });*/

  test('should return model when delete task from database successfully',
      () async {
    //arrange
    when(() => _dbService!.deleteItem(any())).thenAnswer((_) async => 2);
    //act
    final result = await localSource!.deleteTask(task);
    //assert
    expect(result, equals(task));
  });

  test('should return model when update task from database successfully',
      () async {
    //arrange
    when(() => _dbService!.updateTask(task)).thenAnswer((_) async => 2);
    //act
    final result = await localSource!.updateTask(task);
    //assert
    expect(result, equals(task));
  });
}
