part of 'quiz_course_bloc.dart';

abstract class QuizCourseState {}

class QuizCourseInitial extends QuizCourseState {}

// Quizzes List
class GetQuizzesLoading extends QuizCourseState {}

class GetQuizzesSuccess extends QuizCourseState
    implements PaginatedState<QuizModel, QuizPaginatedUIModel> {
  @override
  final QuizPaginatedUIModel? uiModel;
  @override
  final bool isPaginationLoading;

  GetQuizzesSuccess(this.uiModel, {this.isPaginationLoading = false});
}

class GetQuizzesError extends QuizCourseState {
  final String message;
  GetQuizzesError(this.message);
}

// Quiz Questions
class GetQuestionsLoading extends QuizCourseState {}

class GetQuestionsSuccess extends QuizCourseState
    implements PaginatedState<QuestionModel, QuestionPaginatedUIModel> {
  @override
  final QuestionPaginatedUIModel? uiModel;
  @override
  final bool isPaginationLoading;

  GetQuestionsSuccess(this.uiModel, {this.isPaginationLoading = false});
}

class GetQuestionsError extends QuizCourseState {
  final String message;
  GetQuestionsError(this.message);
}

// Submit Quiz
class SubmitQuizLoading extends QuizCourseState {}

class SubmitQuizSuccess extends QuizCourseState {
  final AttemptResultModel result;
  SubmitQuizSuccess(this.result);
}

class SubmitQuizError extends QuizCourseState {
  final String message;
  SubmitQuizError(this.message);
}

// Quiz Results
class GetResultsLoading extends QuizCourseState {}

class GetResultsSuccess extends QuizCourseState {
  final List<AttemptResultModel> results;
  GetResultsSuccess(this.results);
}

class GetResultsError extends QuizCourseState {
  final String message;
  GetResultsError(this.message);
}