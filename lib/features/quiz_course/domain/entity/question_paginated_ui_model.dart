import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_state.dart';
import '../../data/model/question_model.dart';

class QuestionPaginatedUIModel extends PaginatedUIModel<QuestionModel> {
  final List<QuestionModel> questions;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final int totalQuestions;

  QuestionPaginatedUIModel({
    required this.questions,
    required this.totalPages,
    required this.currentPage,
    required this.totalQuestions,
  }) : super(
          items: questions,
          totalPages: totalPages,
          currentPage: currentPage,
        );

  @override
  QuestionPaginatedUIModel copyWithItems(
    List<QuestionModel> newItems, {
    int? totalPages,
    int? currentPage,
    int? totalQuestions,
  }) {
    return QuestionPaginatedUIModel(
      questions: newItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalQuestions: totalQuestions ?? this.totalQuestions,
    );
  }
}
