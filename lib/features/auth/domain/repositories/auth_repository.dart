import 'package:dartz/dartz.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/data/model/register_response_model.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<Either<RegisterResponseModel, String>> register(RegisterRequestModel request);
}
