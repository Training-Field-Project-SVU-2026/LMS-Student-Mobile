import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lms_student/core/errors/handle_dio_exception.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/profile/data/model/logout_request_model.dart';
import 'package:lms_student/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  ProfileRepositoryImpl({required this.apiConsumer, required this.cacheHelper});

  @override
  Future<void> logout(LogoutRequestModel request) async {
    try {
      await apiConsumer.post(EndPoint.logout, data: request.toJson());

      await cacheHelper.removeData(key: ApiKey.accessToken);
      await cacheHelper.removeData(key: ApiKey.refreshToken);
      await cacheHelper.removeData(key: ApiKey.user);
      await cacheHelper.removeData(key: ApiKey.isLoggedIn);

    } on DioException catch (e) {

      await cacheHelper.removeData(key: ApiKey.accessToken);
      await cacheHelper.removeData(key: ApiKey.refreshToken);
      await cacheHelper.removeData(key: ApiKey.user);
      await cacheHelper.removeData(key: ApiKey.isLoggedIn);

      throw DioExceptionHandler.handleException(e);
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
