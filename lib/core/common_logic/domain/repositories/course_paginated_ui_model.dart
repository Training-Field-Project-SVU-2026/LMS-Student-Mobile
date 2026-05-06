import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_state.dart';
import '../../data/model/course/course_model.dart';

class CoursePaginatedUIModel extends PaginatedUIModel<CourseModel> {
  final List<CourseModel> courses;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final int totalCourses;

  CoursePaginatedUIModel({
    required this.courses,
    required this.totalPages,
    required this.currentPage,
    required this.totalCourses,
  }) : super(
          items: courses,
          totalPages: totalPages,
          currentPage: currentPage,
        );

  @override
  CoursePaginatedUIModel copyWithItems(
    List<CourseModel> newItems, {
    int? totalPages,
    int? currentPage,
    int? totalCourses,
  }) {
    return CoursePaginatedUIModel(
      courses: newItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalCourses: totalCourses ?? this.totalCourses,
    );
  }
}
