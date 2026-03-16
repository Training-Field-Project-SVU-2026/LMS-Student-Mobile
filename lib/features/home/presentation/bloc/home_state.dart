part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class CoursesInitial extends HomeState {}

class CoursesLoading extends HomeState {}

class CoursesLoaded extends HomeState {
  final List<CourseModel> courses;
  final int? totalCourses;
  final int? totalPages;
  final int? currentPage;

  const CoursesLoaded({
    required this.courses,
    this.totalCourses,
    this.totalPages,
    this.currentPage,
  });

  @override
  List<Object?> get props => [courses, totalCourses, totalPages, currentPage];
}

class CoursesError extends HomeState {
  final String message;

  const CoursesError({required this.message});

  @override
  List<Object> get props => [message];
}
