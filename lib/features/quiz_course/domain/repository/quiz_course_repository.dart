import 'package:dartz/dartz.dart';
import 'package:lms_student/features/quiz_course/data/model/response_attempt_result_model.dart';
import 'package:lms_student/features/quiz_course/data/model/response_attempt_list_model.dart';
import '../entity/quiz_paginated_ui_model.dart';
import '../entity/question_paginated_ui_model.dart';

abstract class QuizCourseRepository {
  Future<Either<String, QuizPaginatedUIModel>> getQuizzesByCourse(String courseSlug, {int page = 1, int pageSize = 10});
  Future<Either<String, QuestionPaginatedUIModel>> getQuizQuestions(String quizSlug, {int page = 1, int pageSize = 10});
  Future<Either<String, ResponseAttemptResultModel>> submitQuiz(String quizSlug, Map<String, dynamic> answers);
  Future<Either<String, ResponseAttemptListModel>> getQuizResults(String quizSlug);
}