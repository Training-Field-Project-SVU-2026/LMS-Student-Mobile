import 'package:dartz/dartz.dart';
import 'package:lms_student/core/common_logic/data/model/user_model.dart';
import 'package:lms_student/features/profile/data/model/change_password_model.dart';
import 'package:lms_student/features/profile/data/model/logout_request_model.dart';

abstract class ProfileRepository {
  
  Future<Either<String, String>> logout(LogoutRequestModel request);
  Future<Either<String, ChangePasswordModel>> changePassword(ChangePasswordModel request);
  Future<Either<String, UserModel>> getProfile(String slug);
 
  Future<Either<String, UserModel>> updateProfile({
  required String slug,
  required String firstName,
  required String lastName,
  required String email,
});

}