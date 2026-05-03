part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetCoursesEvent extends HomeEvent {
  final int page;
  final int pageSize;
  const GetCoursesEvent({this.page = 1, this.pageSize = 10});

  @override
  List<Object> get props => [page, pageSize];
}

class GetMyEnrollmentsEvent extends HomeEvent {
  final int page;
  final int pageSize;
  const GetMyEnrollmentsEvent({this.page = 1, this.pageSize = 10});

  @override
  List<Object> get props => [page, pageSize];
}
