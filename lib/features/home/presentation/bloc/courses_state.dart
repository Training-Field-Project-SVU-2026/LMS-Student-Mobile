part of 'courses_bloc.dart';

sealed class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<CourseModel> courses;

  const CoursesLoaded({required this.courses});

  @override
  List<Object> get props => [courses];
}

class CoursesError extends CoursesState {
  final String message;

  const CoursesError({required this.message});

  @override
  List<Object> get props => [message];
}
