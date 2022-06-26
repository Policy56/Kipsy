import 'package:equatable/equatable.dart';

abstract class AddExistingHouseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddExistingHouseEmpty extends AddExistingHouseState {}

class AddExistingHouseLoading extends AddExistingHouseState {}

class AddExistingHouseLoad extends AddExistingHouseState {
  AddExistingHouseLoad();
}

class AddExistingHouseError extends AddExistingHouseState {
  final String? msg;
  AddExistingHouseError(this.msg);
}
