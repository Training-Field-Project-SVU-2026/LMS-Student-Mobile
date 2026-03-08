part of 'courses_bloc.dart';

sealed class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

// 📌 بس Event واحد : جلب الكورسات
class FetchCoursesEvent extends CoursesEvent {}
