import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/core/errors/handle_dio_exception.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/home/data/model/course_model.dart';
import 'package:lms_student/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiConsumer apiConsumer;

  HomeRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<List<CourseModel>, String>> getAllCourses() async {
    try {
      final response = await apiConsumer.get(EndPoint.allCourses);
      List<CourseModel> courses = [];

      if (response['data'] != null && response['data'] is List) {
        // لو البيانات جاية في key 'data' زي ما شفنا قبل كده
        courses = (response['data'] as List)
            .map((json) => CourseModel.fromJson(json))
            .toList();
      } else if (response is List) {
        courses = response.map((json) => CourseModel.fromJson(json)).toList();
      }
      print("courses from repo: ${courses}");
      return Left(courses);
    } on DioException catch (e) {
      return Right(DioExceptionHandler.handleException(e));
    } catch (e) {
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
