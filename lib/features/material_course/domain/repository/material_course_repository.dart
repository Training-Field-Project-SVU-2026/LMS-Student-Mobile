import 'package:dartz/dartz.dart';
import '../../data/model/course_materials_response_model.dart';

abstract class MaterialCourseRepository {
  Future<Either<String, CourseMaterialsResponseModel>> getCourseMaterials({
    required String slug,
    int? page,
    int? pageSize,
  });
}
