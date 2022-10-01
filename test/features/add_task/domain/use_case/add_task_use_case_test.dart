import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/core/use_case/use_case.dart';
import 'package:kipsy/features/add_task/data/model/task_model.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';
import 'package:kipsy/features/add_task/domain/repositiory/add_and_modify_task_repository.dart';
import 'package:kipsy/features/add_task/domain/use_case/add_task_use_case.dart';

class MockAddTaskRepository extends Mock implements AddAndModifyTaskRepository {
}

void main() {
  MockAddTaskRepository? repository;
  AddTaskUseCase? useCase;

  setUp(() {
    repository = MockAddTaskRepository();
    useCase = AddTaskUseCase(
      repository!,
    );
  });

  final tTask = TaskOfListEntity(
      titre: '', description: '', isDone: false, dateTime: null, views: 0);

  final tTaskOfListModel = TaskOfListModel(
      titre: '', description: '', isDone: false, dateTime: null, views: 0);

  test('should return [Task Entity] when data return success', () async {
    //arrange
    when(() => repository!.addTask(tTaskOfListModel))
        .thenAnswer((_) async => Right(tTask));
    //act
    final result = await useCase!(AddTaskParam(tTaskOfListModel));
    //assert
    verify(() => repository!.addTask(tTaskOfListModel));
    verifyNoMoreInteractions(repository);
    expect(result, equals(Right(tTask)));
  });

  test('should return [Failure] when data return error', () async {
    //arrange
    when(() => repository!.addTask(tTaskOfListModel))
        .thenAnswer((_) async => const Left(Failure()));
    //act
    final result = await useCase!(AddTaskParam(tTaskOfListModel));
    //assert
    verify(() => repository!.addTask(tTaskOfListModel));
    verifyNoMoreInteractions(repository);
    expect(result, equals(const Left(Failure())));
  });
}
