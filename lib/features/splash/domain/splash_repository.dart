import 'package:dartz/dartz.dart';
import 'package:lms_student/features/splash/data/model/check_auth_response_model.dart';

abstract class SplashRepository {
  Future<Either<CheckAuthDataModel, String>> checkLogin();
}