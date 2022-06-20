import 'package:equatable/equatable.dart';
import 'package:kipsy/features/add_house/domain/entity/house.dart';

abstract class AddHouseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddHouseEmpty extends AddHouseState {}

class AddHouseLoading extends AddHouseState {}

class AddHouseLoad extends AddHouseState {
  final HouseEntity? house;
  AddHouseLoad({this.house});
}

class AddHouseError extends AddHouseState {
  final String? msg;
  AddHouseError(this.msg);
}
