import 'package:dartz/dartz.dart';
import 'package:lms_student/features/home/data/model/course_model.dart';

abstract class HomeRepository {
  // الأساسيات اللي محتاجها أكيد
  Future<Either<List<CourseModel>, String>> getAllCourses();
  Future<Either<CourseModel, String>> getCourseById(int id);
  Future<Either<List<CourseModel>, String>> searchInCourses(String query);
}
