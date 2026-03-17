import 'package:dartz/dartz.dart';
import 'package:lms_student/features/auth/data/model/login_request_model.dart';
import 'package:lms_student/features/auth/data/model/login_response_model.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/data/model/register_response_model.dart';
import 'package:lms_student/features/auth/data/model/reset_password_request_model.dart';
import 'package:lms_student/features/auth/data/model/verify_email_request_model.dart';

abstract class AuthRepository {
  Future<Either<String, LoginResponseModel>> login(LoginRequestModel request);
  Future<Either<String, RegisterResponseModel>> register(
    RegisterRequestModel request,
  );
  Future<Either<String, String>> verifyEmail(VerifyEmailRequestModel request);

  Future<Either<String, String>> resendOtp(String email);

  Future<Either<String, String>> forgotPassword(String email);

  Future<Either<String, String>> resetPassword(ResetPasswordRequestModel request);
}

