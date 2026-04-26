import 'package:dartz/dartz.dart';
import 'package:lms_student/features/quiz_course/data/model/quiz_course_model.dart';
import 'package:lms_student/features/quiz_course/domain/repository/quiz_course_repository.dart';

class QuizCourseRepositoryImpl implements QuizCourseRepository {
  @override
  Future<Either<String, List<QuizCourseModel>>> getQuizCourse() {
    // TODO: implement getQuizCourse
    throw UnimplementedError();
  }
}