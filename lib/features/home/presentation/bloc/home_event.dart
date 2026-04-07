part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetCoursesEvent extends HomeEvent {}

class GetMyEnrollmentsEvent extends HomeEvent {
  const GetMyEnrollmentsEvent();
  @override
  List<Object> get props => [];
}
