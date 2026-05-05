
import 'package:equatable/equatable.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class GetpackagesEvent extends ExploreEvent {
  final int? page;
  final int? pageSize;
  const GetpackagesEvent({this.page, this.pageSize});
}

class GetCoursesEvent extends ExploreEvent {
  final int? page;
  final int? pageSize;
  const GetCoursesEvent({this.page, this.pageSize});
}
