abstract class ShowHouseState {}

class HomeEmpty extends ShowHouseState {}

class HomeLoading extends ShowHouseState {}

class HomeLoaded extends ShowHouseState {}

class HomeError extends ShowHouseState {
  final String? msg;
  HomeError(this.msg);
}
