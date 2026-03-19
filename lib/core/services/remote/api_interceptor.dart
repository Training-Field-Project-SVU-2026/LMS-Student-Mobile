import 'package:dio/dio.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';

class ApiInterceptor extends Interceptor {
  final CacheHelper _cacheHelper = CacheHelper();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains('/auth/login') &&
        !options.path.contains('/auth/register')) {
      final token = _cacheHelper.getData(key: ApiKey.accessToken);
      if (token != null) {
        options.headers[ApiKey.authorization] = 'Bearer $token';
      }
    }
    super.onRequest(options, handler);
  }

//! look at this ya قائد  i didn't review it 
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // If we catch a 401 Unauthorized, the token might be expired.
    if (err.response?.statusCode == 401) {
      final path = err.requestOptions.path;

      // Do not try to refresh if the 401 came from login or the refresh endpoint itself
      if (!path.contains('/auth/login') &&
          !path.contains(EndPoint.refreshToken)) {
        final refreshToken = _cacheHelper.getData(key: ApiKey.refreshToken);

        if (refreshToken != null) {
          try {
            // Attempt to refresh the token using a clean Dio instance
            final refreshDio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));
            final response = await refreshDio.post(
              EndPoint.refreshToken,
              data: {'refresh': refreshToken},
            );

            if (response.statusCode == 200 || response.statusCode == 201) {
              final responseData = response.data;
              String? newAccessToken;

              // Handle both raw JWT and wrapped { "data": { "access": "..." } } formats
              if (responseData is Map<String, dynamic>) {
                if (responseData.containsKey('data')) {
                  newAccessToken = responseData['data']['access'];
                } else if (responseData.containsKey('access')) {
                  newAccessToken = responseData['access'];
                }
              }

              if (newAccessToken != null) {
                // Save the new token
                await _cacheHelper.saveData(
                  key: ApiKey.accessToken,
                  value: newAccessToken,
                );

                // Update the failed request with the new token
                err.requestOptions.headers[ApiKey.authorization] =
                    'Bearer $newAccessToken';

                // Retry the original request
                final retryDio = Dio();
                final retryResponse = await retryDio.fetch(err.requestOptions);
                return handler.resolve(retryResponse);
              }
            }
          } catch (e) {
            // If the refresh token is also invalid/expired, we log out
            await _cacheHelper.clearUserData();
          }
        }
      }
    }
    super.onError(err, handler);
  }
}
