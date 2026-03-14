import 'package:dartz/dartz.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/common/data/model/course_model.dart';
import 'package:lms_student/features/common/data/model/response_course_model.dart';
import 'package:lms_student/features/common/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiConsumer apiConsumer;

  CourseRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<ResponseCourseModel, String>> getAllCourses() async {
    try {
      final responseData = await apiConsumer.get(EndPoint.allCourses);
      final response = ResponseCourseModel.fromJson(responseData);

      if (response.success && (response.status == 200 || response.status == 201)) {
        return Left(response);
      } else {
        return Right(response.message);
      }
    } catch (e) {
      if (e is String) {
        return Right(e);
      }
      return Right('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Either<CourseModel, String>> getCourseBySlug(String slug) {
    throw UnimplementedError();
  }

  @override
  Future<Either<List<CourseModel>, String>> searchInCourses(String query) {
    throw UnimplementedError();
  }
}
