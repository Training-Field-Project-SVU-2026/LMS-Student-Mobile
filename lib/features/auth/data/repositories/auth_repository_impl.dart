import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/core/errors/handle_dio_exception.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/auth/data/model/login_request_model.dart';
import 'package:lms_student/features/auth/data/model/login_response_model.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/data/model/register_response_model.dart';
import 'package:lms_student/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  AuthRepositoryImpl({required this.apiConsumer, required this.cacheHelper});

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
      return Right(
        'An unexpected error occurred in registration : ${e.toString()}',
      );
    }
  }

  @override
  Future<Either<LoginResponseModel, String>> login(
    LoginRequestModel request,
  ) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.login,
        data: request.toJson(),
      );

      final loginResponse = LoginResponseModel.fromJson(
        response.data, 
        response.statusCode ?? 0,
      );

      
      if (loginResponse.isSuccess) {
        await cacheHelper.saveData(
          key: 'access_token', 
          value: loginResponse.accessToken,
        );
        await cacheHelper.saveData(
          key: 'refresh_token', 
          value: loginResponse.refreshToken,
        );
        await cacheHelper.saveData(
          key: 'user', 
          value: loginResponse.user.toJson(),
        );
        await cacheHelper.saveData(
          key: 'is_logged_in', 
          value: true,
        );
      }

      return Left(loginResponse);
    } on DioException catch (e) {
      return Right(DioExceptionHandler.handleException(e));
    } catch (e) {
      return Right('An unexpected error occurred in Login : ${e.toString()}');
    }
  }
}
