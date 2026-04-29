import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_state.dart';
import '../../data/model/quiz_model.dart';

class QuizPaginatedUIModel extends PaginatedUIModel<QuizModel> {
  final List<QuizModel> quizzes;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final int totalQuizzes;

  QuizPaginatedUIModel({
    required this.quizzes,
    required this.totalPages,
    required this.currentPage,
    required this.totalQuizzes,
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
  }) {
    return QuizPaginatedUIModel(
      quizzes: newItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
    );
  }

  List<QuizModel> get completedQuizzes => quizzes.where((q) => q.isPassed || q.isFailed).toList();
  List<QuizModel> get pendingQuizzes => quizzes.where((q) => q.isNotStarted || q.isCanRetry).toList();
}
