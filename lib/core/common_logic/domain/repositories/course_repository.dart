import 'package:dartz/dartz.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/data/model/course/response_course_model.dart';

abstract class CourseRepository {
  Future<Either<String, ResponseCourseModel>> getAllCourses({
    int? page,
    int? pageSize,
  });
  Future<Either<String, CourseModel>> getCourseBySlug(String slug);
  Future<Either<String, List<CourseModel>>> searchInCourses(String query);
}

