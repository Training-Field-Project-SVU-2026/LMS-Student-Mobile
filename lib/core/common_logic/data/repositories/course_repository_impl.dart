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
  Future<Either<String, ResponseCourseModel>> getAllCourses({
    int? page,
    int? pageSize,
  }) async {
    return await apiConsumer.get<ResponseCourseModel>(
      EndPoint.allCourses,
      queryParameters: {'page': page, 'page_size': pageSize},
      fromJson: (json) => ResponseCourseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, ResponseCourseBySlugModel>> getCourseBySlug(
    String slug,
  ) async {
    return await apiConsumer.get<ResponseCourseBySlugModel>(
      '${EndPoint.courseBySlug}$slug/',
      fromJson: (json) => ResponseCourseBySlugModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, List<CourseModel>>> searchInCourses(String query) {
    throw UnimplementedError();
  }
}
