import 'package:dartz/dartz.dart';
import 'package:lms_student/core/common_logic/data/model/user_model.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/profile/data/model/change_password_model.dart';
import 'package:lms_student/features/profile/data/model/logout_request_model.dart';
import 'package:lms_student/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  ProfileRepositoryImpl({required this.apiConsumer, required this.cacheHelper});

  @override
  Future<Either<String, String>> logout(LogoutRequestModel request) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.logout,
      data: request.toJson(),
    );

    return result.fold(
      (error) {
        cacheHelper.clearUserData();
        return Left(error);
      },
      (data) async {
        await cacheHelper.clearUserData();
        return Right(data['message']?.toString() ?? 'Logged out successfully');
      },
    );
  }

  @override
  Future<Either<String, ChangePasswordModel>> changePassword(
    ChangePasswordModel request,
  ) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.changePassword,
      data: request.toJson(),
    );

    return result.fold(
      (error) => Left(error),
      (data) => Right(ChangePasswordModel.fromJson(data)),
    );
  }

  @override
  Future<Either<String, UserModel>> getProfile(String slug) async {
    final result = await apiConsumer.get<Map<String, dynamic>>(
      EndPoint.studentProfile(slug),
    );

    return result.fold(
      (error) => Left(error),
      (data) => Right(UserModel.fromJson(data)),
    );
  }

  @override
  Future<Either<String, UserModel>> updateProfile({
    required String slug,
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final result = await apiConsumer.put<Map<String, dynamic>>(
      EndPoint.updateProfile(slug),
      data: {
        ApiKey.firstName: firstName,
        ApiKey.lastName: lastName,
        ApiKey.email: email,
      },
    );

    return result.fold(
      (error) => Left(error),
      (data) => Right(UserModel.fromJson(data)),
    );
  }
}
