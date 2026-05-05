import 'package:equatable/equatable.dart';

abstract class MyCoursesEvent extends Equatable {
  const MyCoursesEvent();

  @override
  List<Object?> get props => [];
}

class GetMyCoursesEvent extends MyCoursesEvent {
  final int page;
  final int pageSize;

  const GetMyCoursesEvent({this.page = 1, this.pageSize = 10});

  @override
  List<Object?> get props => [page, pageSize];
}

class SearchMyCoursesEvent extends MyCoursesEvent {
  final String query;

  const SearchMyCoursesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterMyCoursesEvent extends MyCoursesEvent {
  final String status; // 'All', 'Ongoing', 'Completed'

  const FilterMyCoursesEvent(this.status);

  @override
  List<Object?> get props => [status];
}
