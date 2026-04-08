part of 'coursedetails_bloc.dart';

sealed class CoursedetailsState extends Equatable {
  const CoursedetailsState();

  @override
  List<Object> get props => [];
}

class CoursedetailsInitial extends CoursedetailsState {}

class CourseLoading extends CoursedetailsState {}

class CourseLoaded extends CoursedetailsState {
  final CourseModel course;

  const CourseLoaded({required this.course});

  @override
  List<Object> get props => [course];
}

class CourseError extends CoursedetailsState {
  final String message;

  const CourseError({required this.message});

  @override
  List<Object> get props => [message];
}

class CourseEnrollLoading extends CoursedetailsState {}

class CourseEnrollLoaded extends CoursedetailsState {
  final CourseModel course;

  const CourseEnrollLoaded({required this.course});

  @override
  List<Object> get props => [course];
}

class CourseEnrollError extends CoursedetailsState {
  final String message;

  const CourseEnrollError({required this.message});

  @override
  List<Object> get props => [message];
}
