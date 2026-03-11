import 'package:dartz/dartz.dart';
import 'package:lms_student/features/auth/data/model/login_request_model.dart';
import 'package:lms_student/features/auth/data/model/login_response_model.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/data/model/register_response_model.dart';
import 'package:lms_student/features/auth/data/model/verify_email_request_model.dart';

abstract class AuthRepository {
  Future<Either<LoginResponseModel, String>> login(LoginRequestModel request);
  Future<Either<RegisterResponseModel, String>> register(
    RegisterRequestModel request,
  );
  Future<String> verifyEmail(VerifyEmailRequestModel request);

  Future<String> resendOtp(String email);
}
