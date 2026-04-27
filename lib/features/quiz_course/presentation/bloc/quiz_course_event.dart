part of 'quiz_course_bloc.dart';

abstract class QuizCourseEvent {}

class GetQuizzesByCourseEvent extends QuizCourseEvent {
  final String courseSlug;
  final int page;
  GetQuizzesByCourseEvent(this.courseSlug, {this.page = 1});
}

class GetQuizQuestionsEvent extends QuizCourseEvent {
  final String quizSlug;
  final int page;
  GetQuizQuestionsEvent(this.quizSlug, {this.page = 1});
}

class SubmitQuizEvent extends QuizCourseEvent {
  final String quizSlug;
  final List<Map<String, dynamic>> answers;
  SubmitQuizEvent(this.quizSlug, this.answers);
}

class GetQuizResultsEvent extends QuizCourseEvent {
  final String quizSlug;
  GetQuizResultsEvent(this.quizSlug);
}