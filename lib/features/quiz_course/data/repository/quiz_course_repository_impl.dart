import 'package:dartz/dartz.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/quiz_course/data/model/response_quiz_list_model.dart';
import 'package:lms_student/features/quiz_course/data/model/response_quiz_detail_model.dart';
import 'package:lms_student/features/quiz_course/data/model/response_attempt_result_model.dart';
import 'package:lms_student/features/quiz_course/data/model/response_attempt_list_model.dart';
import 'package:lms_student/features/quiz_course/domain/repository/quiz_course_repository.dart';
import 'package:lms_student/features/quiz_course/domain/entity/quiz_paginated_ui_model.dart';
import 'package:lms_student/features/quiz_course/domain/entity/question_paginated_ui_model.dart';
import 'package:lms_student/core/utils/api_query_params.dart';

class QuizCourseRepositoryImpl implements QuizCourseRepository {
  final ApiConsumer apiConsumer;

  QuizCourseRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, QuizPaginatedUIModel>> getQuizzesByCourse(String courseSlug, {int page = 1, int pageSize = 10}) async {
    final response = await apiConsumer.get<ResponseQuizListModel>(
      EndPoint.allQuizzzesByCourse(courseSlug),
      queryParameters: ApiQueryParams.pagination(page: page, pageSize: pageSize),
      fromJson: (json) => ResponseQuizListModel.fromJson(json),
    );

    return response.fold(
      (error) => Left(error),
      (model) => Right(QuizPaginatedUIModel(
        quizzes: model.data.quizzes,
        totalPages: model.data.totalPages,
        currentPage: model.data.currentPage,
        totalQuizzes: model.data.totalQuizzes,
      )),
    );
  }

  @override
  Future<Either<String, QuestionPaginatedUIModel>> getQuizQuestions(String quizSlug, {int page = 1, int pageSize = 10}) async {
    final response = await apiConsumer.get<ResponseQuizDetailModel>(
      EndPoint.quizQuestions(quizSlug),
      queryParameters: ApiQueryParams.pagination(page: page, pageSize: pageSize),
      fromJson: (json) => ResponseQuizDetailModel.fromJson(json),
    );

    return response.fold(
      (error) => Left(error),
      (model) => Right(QuestionPaginatedUIModel(
        questions: model.data.questions,
        totalPages: model.data.totalPages,
        currentPage: model.data.currentPage,
        totalQuestions: model.data.totalQuestions,
      )),
    );
  }

  @override
  Future<Either<String, ResponseAttemptResultModel>> submitQuiz(String quizSlug, Map<String, dynamic> answers) async {
    return await apiConsumer.post<ResponseAttemptResultModel>(
      EndPoint.submitQuiz(quizSlug),
      data: answers,
      fromJson: (json) => ResponseAttemptResultModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, ResponseAttemptListModel>> getQuizResults(String quizSlug) async {
    return await apiConsumer.get<ResponseAttemptListModel>(
      EndPoint.quizResults(quizSlug),
      fromJson: (json) => ResponseAttemptListModel.fromJson(json),
    );
  }
}