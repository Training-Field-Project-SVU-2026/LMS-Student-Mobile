import 'dart:convert';
import 'package:dartz/dartz.dart';
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
  Future<Either<String, RegisterResponseModel>> register(
    RegisterRequestModel request,
  ) async {
    return await apiConsumer.post<RegisterResponseModel>(
      EndPoint.register,
      data: request.toJson(),
      fromJson: (json) => RegisterResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, LoginResponseModel>> login(
    LoginRequestModel request,
  ) async {
    final result = await apiConsumer.post<LoginResponseModel>(
      EndPoint.login,
      data: request.toJson(),
      fromJson: (json) => LoginResponseModel.fromJson(json),
    );

    return await result.fold((error) => Left(error), (loginResponse) async {
      await cacheHelper.saveData(
        key: ApiKey.accessToken,
        value: loginResponse.accessToken,
      );
      await cacheHelper.saveData(
        key: ApiKey.refreshToken,
        value: loginResponse.refreshToken,
      );
      await cacheHelper.saveData(key: ApiKey.isLoggedIn, value: true);

      final userJson = jsonEncode(loginResponse.user.toJson());
      await cacheHelper.saveData(key: ApiKey.user, value: userJson);
      
      await cacheHelper.saveData(key: ApiKey.firstName, value: loginResponse.user.firstName);
      await cacheHelper.saveData(key: ApiKey.lastName, value: loginResponse.user.lastName);
      await cacheHelper.saveData(key: ApiKey.email, value: loginResponse.user.email);
      await cacheHelper.saveData(key: ApiKey.image, value: loginResponse.user.image);

      await cacheHelper.saveData(
        key: ApiKey.slug,
        value: loginResponse.user.slug,
      );
      return Right(loginResponse);
    });
  }

  @override
  Future<Either<String, String>> verifyEmail(
    VerifyEmailRequestModel request,
  ) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.verifyEmail,
      data: request.toJson(),
    );
    return result.fold(
      (error) => Left(error),
      (data) =>
          Right(data['message']?.toString() ?? 'Email verified successfully'),
    );
  }

  @override
  Future<Either<String, String>> resendOtp(String email) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.resendOtp,
      data: {"email": email},
    );
    return result.fold(
      (error) => Left(error),
      (data) => Right(data['message']?.toString() ?? 'OTP resent successfully'),
    );
  }

  @override
  Future<Either<String, String>> forgotPassword(String email) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.forgotPassword,
      data: {"email": email},
    );
    return result.fold(
      (error) => Left(error),
      (data) =>
          Right(data['message']?.toString() ?? 'Reset link sent successfully'),
    );
  }

  @override
  Future<Either<String, String>> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.resetPassword,
      data: request.toJson(),
    );
    return result.fold(
      (error) => Left(error),
      (data) =>
          Right(data['message']?.toString() ?? 'Password reset successfully'),
    );
  }
}
