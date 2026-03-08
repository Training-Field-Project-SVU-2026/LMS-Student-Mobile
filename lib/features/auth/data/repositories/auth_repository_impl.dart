import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/core/errors/handle_dio_exception.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/data/model/register_response_model.dart';
import 'package:lms_student/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;
  AuthRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<RegisterResponseModel, String>> register(
    RegisterRequestModel request,
  ) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.register,
        data: request.toJson(),
      );

      return Left(
        RegisterResponseModel.fromJson(response.data, response.statusCode ?? 0),
      );
    } on DioException catch (e) {
      return Right(DioExceptionHandler.handleException(e));
    } catch (e) {
      return Right('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    // Implementation using apiConsumer (هنعمله بعدين)
  }
}
