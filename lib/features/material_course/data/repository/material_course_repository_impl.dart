import 'package:dartz/dartz.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/core/utils/api_query_params.dart';
import '../../domain/repository/material_course_repository.dart';
import '../model/course_materials_response_model.dart';

class MaterialCourseRepositoryImpl implements MaterialCourseRepository {
  final ApiConsumer apiConsumer;

  MaterialCourseRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseMaterialsResponseModel>> getCourseMaterials({
    required String slug,
    int? page,
    int? pageSize,
  }) async {
    return await apiConsumer.get<CourseMaterialsResponseModel>(
      EndPoint.courseMaterials(slug),
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
      ),
      fromJson: (json) => CourseMaterialsResponseModel.fromJson(json),
    );
  }
}
