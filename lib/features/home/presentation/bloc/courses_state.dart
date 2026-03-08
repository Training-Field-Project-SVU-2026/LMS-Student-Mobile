part of 'courses_bloc.dart';

sealed class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

// 🟡 حالة البداية
class CoursesInitial extends CoursesState {}

// 🔵 حالة التحميل
class CoursesLoading extends CoursesState {}

// 🟢 حالة نجاح جلب الكورسات
class CoursesLoaded extends CoursesState {
  final List<CourseModel> courses;

  const CoursesLoaded({required this.courses});

  @override
  List<Object> get props => [courses];
}

// 🔴 حالة الخطأ
class CoursesError extends CoursesState {
  final String message;

  const CoursesError({required this.message});

  @override
  List<Object> get props => [message];
}
