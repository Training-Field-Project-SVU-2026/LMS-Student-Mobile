import 'package:dio/dio.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains('/auth/login') && !options.path.contains('/auth/register')) {
      options.headers[ApiKey.authorization] =
          CacheHelper().getData(key: ApiKey.accessToken) != null
          ? 'Bearer ${CacheHelper().getData(key: ApiKey.accessToken)}'
          : null;
    }
    super.onRequest(options, handler);
  }
}
