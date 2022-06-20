import 'package:equatable/equatable.dart';
import 'package:kipsy/features/add_list/domain/entity/list_of_house.dart';

abstract class AddListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddListEmpty extends AddListState {}

class AddListLoading extends AddListState {}

class AddListLoad extends AddListState {
  final ListesOfHouseEntity? list;
  AddListLoad({this.list});
}

class AddListError extends AddListState {
  final String? msg;
  AddListError(this.msg);
}
