import 'package:dartz/dartz.dart';
import 'package:lms_student/core/common_logic/data/model/course/responsecoursebyslugmodel.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/data/model/course/response_course_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiConsumer apiConsumer;

  CourseRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<ResponseCourseModel, String>> getAllCourses({
    int? page,
    int? pageSize,
  }) async {
    try {
      final responseData = await apiConsumer.get(
        EndPoint.allCourses,
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      final response = ResponseCourseModel.fromJson(responseData);

      if (response.success &&
          (response.status == 200 || response.status == 201)) {
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
  Future<Either<CourseModel, String>> getCourseBySlug(String slug) async {
    try {
      final responseData = await apiConsumer.get(
        '${EndPoint.courseBySlug}$slug/',
      );
      final response = ResponseCourseBySlugModel.fromJson(responseData);
      if (response.success &&
          (response.status == 200 || response.status == 201)) {
        return Left(response.data);
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
  Future<Either<List<CourseModel>, String>> searchInCourses(String query) {
    throw UnimplementedError();
  }
}
