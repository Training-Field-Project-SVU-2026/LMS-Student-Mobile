import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms_student/core/errors/handle_dio_exception.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/splash/data/model/check_auth_response_model.dart';
import 'package:lms_student/features/splash/domain/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  SplashRepositoryImpl({required this.apiConsumer, required this.cacheHelper});
  @override
  Future<Either<CheckAuthDataModel, String>> checkLogin() async {
    try {
      if (cacheHelper.getData(key: ApiKey.accessToken) == null ||
          cacheHelper.getData(key: ApiKey.accessToken) == "") {
        return Left(CheckAuthDataModel(message: "No token found"));
      }

      final response = await apiConsumer.get(EndPoint.checkToken);
      final checkAuthResponseModel = CheckAuthResponseModel.fromJson(response);
      if (checkAuthResponseModel.data != null) {
        return Left(checkAuthResponseModel.data!);
      } else {
        return Right(checkAuthResponseModel.message!);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await cacheHelper.removeData(key: ApiKey.accessToken);
        await cacheHelper.removeData(key: ApiKey.refreshToken);
        await cacheHelper.removeData(key: ApiKey.user);
        await cacheHelper.removeData(key: ApiKey.isLoggedIn);
        return Left(CheckAuthDataModel(message: "Session expired"));
      }
      return Right(DioExceptionHandler.handleException(e));
    } catch (e) {
      if (e.toString().contains("Unauthorized")) {
        await cacheHelper.removeData(key: ApiKey.accessToken);
        await cacheHelper.removeData(key: ApiKey.refreshToken);
        await cacheHelper.removeData(key: ApiKey.user);
        await cacheHelper.removeData(key: ApiKey.isLoggedIn);
        return Left(CheckAuthDataModel(message: "Session expired"));
      }
      return Right(e.toString());
    }
  }
}
