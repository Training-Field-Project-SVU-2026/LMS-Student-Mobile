import 'package:dartz/dartz.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/data/model/course/response_course_model.dart';

abstract class CourseRepository {
  Future<Either<ResponseCourseModel, String>> getAllCourses({
    int? page,
    int? pageSize,
  });
  Future<Either<CourseModel, String>> getCourseBySlug(String slug);
  Future<Either<List<CourseModel>, String>> searchInCourses(String query);
}
