import 'package:equatable/equatable.dart';
import 'package:kipsy/features/add_task/domain/entity/task_of_list.dart';

abstract class AddAndModifyTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAndModifyTaskEmpty extends AddAndModifyTaskState {}

class AddAndModifyTaskLoading extends AddAndModifyTaskState {}

class AddAndModifyTaskLoad extends AddAndModifyTaskState {
  final TaskOfListEntity? task;
  AddAndModifyTaskLoad({this.task});
}

class AddAndModifyTaskError extends AddAndModifyTaskState {
  final String? msg;
  AddAndModifyTaskError(this.msg);
}

class AddAndModifyTypeTask extends AddAndModifyTaskState {}

class RemoveTypeTask extends AddAndModifyTaskState {}
