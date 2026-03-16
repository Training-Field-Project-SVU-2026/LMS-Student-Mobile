import 'package:dartz/dartz.dart';
import 'package:lms_student/features/common/data/model/course_model.dart';
import 'package:lms_student/features/common/data/model/response_course_model.dart';

abstract class CourseRepository {
  Future<Either<ResponseCourseModel, String>> getAllCourses();
  Future<Either<CourseModel, String>> getCourseBySlug(String slug);
  Future<Either<List<CourseModel>, String>> searchInCourses(String query);
}
