import 'package:dartz/dartz.dart';
import 'package:lms_student/features/quiz_course/data/model/quiz_course_model.dart';

abstract class QuizCourseRepository {
  Future<Either<String, List<QuizCourseModel>>> getQuizCourse();
}