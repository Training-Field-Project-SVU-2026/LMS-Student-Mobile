part of 'quiz_course_bloc.dart';

abstract class QuizCourseState {}

class QuizCourseInitial extends QuizCourseState {}

class QuizCourseStateError extends QuizCourseState {
  final String message;
  QuizCourseStateError({required this.message});
}