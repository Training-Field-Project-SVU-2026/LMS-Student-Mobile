import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_state.dart';
import '../../data/model/quiz_model.dart';

class QuizPaginatedUIModel extends PaginatedUIModel<QuizModel> {
  final List<QuizModel> quizzes;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final int totalQuizzes;
  final String overallBestScore;
  final String completedQuizzes;

  QuizPaginatedUIModel({
    required this.quizzes,
    required this.totalPages,
    required this.currentPage,
    required this.totalQuizzes,
    required this.overallBestScore,
    required this.completedQuizzes,
  }) : super(
          items: quizzes,
          totalPages: totalPages,
          currentPage: currentPage,
        );

  @override
  QuizPaginatedUIModel copyWithItems(
    List<QuizModel> newItems, {
    int? totalPages,
    int? currentPage,
    int? totalQuizzes,
    String? overallBestScore,
    String? completedQuizzes,
  }) {
    return QuizPaginatedUIModel(
      quizzes: newItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      overallBestScore: overallBestScore ?? this.overallBestScore,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
    );
  }

  List<QuizModel> get completedQuizzesList => quizzes.where((q) => q.isPassed || q.isFailed).toList();
  List<QuizModel> get pendingQuizzesList => quizzes.where((q) => q.isNotStarted || q.isCanRetry).toList();
}
