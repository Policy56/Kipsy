import 'package:dartz/dartz.dart';
import 'package:kipsy/core/error/failure.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

abstract class UseCase<Out, Params> {
  Future<Either<Failure, Out>> call(Params params);
}

class AddTaskParam {
  final TaskOfListEntity? taskOfListEntity;
  AddTaskParam(this.taskOfListEntity);
}

class AddListParam {
  final ListesOfHouseEntity? listesOfHouseEntity;
  AddListParam(this.listesOfHouseEntity);
}

class AddHouseParam {
  final HouseEntity? houseEntity;
  AddHouseParam(this.houseEntity);
}

class AddExistingHouseParam {
  final String shareCode;
  AddExistingHouseParam(this.shareCode);
}

class NoParams {}

class HouseParams {
  final HouseEntity? houseEntity;
  const HouseParams({this.houseEntity});
}

class ListesOfHouseParams {
  final ListesOfHouseEntity? listesOfHouseEntity;
  const ListesOfHouseParams({this.listesOfHouseEntity});
}

class TaskOfListesParams {
  final TaskOfListEntity? taskOfListesEntity;
  const TaskOfListesParams({this.taskOfListesEntity});
}
