import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_tasks_repository.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_task_use_case.dart';

class MockHomeRepository extends Mock implements ShowTasksOfListesRepository {}

void main() {
  MockHomeRepository? repository;
  UpdateTaskUSeCase? updateTask;

  setUp(() {
    repository = MockHomeRepository();
    updateTask = UpdateTaskUSeCase(repository!);
  });

  final task = TaskOfListEntity(
      titre: '',
      description: '',
      dateTime: null,
      isDone: false,
      views: 0,
      id: 0.toString());

  test('should call repository one time when call update use case', () async {
    //arrange
    when(() => repository!.updateTask(task))
        .thenAnswer((_) async => Right(task));
    //act
    await updateTask!(TaskOfListesParams(taskOfListesEntity: task));
    //assert
    verify(() => repository!.updateTask(task));
    verifyNoMoreInteractions(repository);
  });

  test('should return updated task when return right side of repository',
      () async {
    //arrange
    when(() => repository!.updateTask(task))
        .thenAnswer((_) async => Right(task));
    //act
    final result =
        await updateTask!(TaskOfListesParams(taskOfListesEntity: task));
    //assert
    expect(result, equals(Right(task)));
  });

  test('should return failure when repository return [ERROR] failure',
      () async {
    //arrange
    when(() => repository!.updateTask(task))
        .thenAnswer((_) async => const Left(Failure()));
    //act
    final result =
        await updateTask!(TaskOfListesParams(taskOfListesEntity: task));
    //assert
    expect(result, equals(const Left(Failure())));
  });
}
