import 'package:dartz/dartz.dart';
import 'package:lms_student/features/home/data/model/course_model.dart';

abstract class HomeRepository {
  Future<Either<List<CourseModel>, String>> getAllCourses();
  Future<Either<CourseModel, String>> getCourseBySlug(String slug);
  Future<Either<List<CourseModel>, String>> searchInCourses(String query);
}
