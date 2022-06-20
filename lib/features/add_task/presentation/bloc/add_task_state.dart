import 'package:equatable/equatable.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

abstract class AddTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTaskEmpty extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskLoad extends AddTaskState {
  final TaskOfListEntity? task;
  AddTaskLoad({this.task});
}

class AddTaskError extends AddTaskState {
  final String? msg;
  AddTaskError(this.msg);
}
