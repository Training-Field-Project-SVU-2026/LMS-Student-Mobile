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
import 'package:lms_student/features/auth/data/model/reset_password_request_model.dart';
import 'package:lms_student/features/auth/data/model/verify_email_request_model.dart';
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

      return Left(RegisterResponseModel.fromJson(response));
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

      final loginResponse = LoginResponseModel.fromJson(response);

      await cacheHelper.saveData(
        key: ApiKey.accessToken,
        value: loginResponse.accessToken,
      );
      await cacheHelper.saveData(
        key: ApiKey.refreshToken,
        value: loginResponse.refreshToken,
      );
      await cacheHelper.saveData(
        key: ApiKey.user,
        value: loginResponse.user.toJson().toString(),
      );
      await cacheHelper.saveData(key: ApiKey.isLoggedIn, value: true);

      return Left(loginResponse);
    } on DioException catch (e) {
      return Right(DioExceptionHandler.handleException(e));
    } catch (e) {
      return Right('An unexpected error occurred in Login : ${e.toString()}');
    }
  }

  @override
  Future<String> verifyEmail(VerifyEmailRequestModel request) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.verifyEmail,
        data: request.toJson(),
      );

      print(response);
      return response.toString(); //
    } on DioException catch (e) {
      return DioExceptionHandler.handleException(e);
    } catch (e) {
      return 'An unexpected error occurred in Verify Email : ${e.toString()}';
    }
  }

  @override
  Future<String> resendOtp(String email) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.resendOtp,
        data: {"email": email},
      );
      return response.toString();
    } on DioException catch (e) {
      return DioExceptionHandler.handleException(e);
    } catch (e) {
      return 'An unexpected error occurred in Resend OTP : ${e.toString()}';
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.forgotPassword,
        data: {"email": email},
      );

      return response.toString();
    } on DioException catch (e) {
      return DioExceptionHandler.handleException(e);
    } catch (e) {
      return 'An unexpected error occurred in Resend OTP (Forgot password): ${e.toString()}';
    }
  }

  @override
  Future<String> resetPassword(ResetPasswordRequestModel request) async {
     try {
      final response = await apiConsumer.post(
        EndPoint.resetPassword,
        data: request.toJson()
      );

      return response.toString();
    } on DioException catch (e) {
      return DioExceptionHandler.handleException(e);
    } catch (e) {
      return 'An unexpected error occurred in Reset password: ${e.toString()}';
    }  
  }
}
