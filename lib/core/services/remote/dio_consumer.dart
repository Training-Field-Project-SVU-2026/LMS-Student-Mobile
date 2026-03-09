// import 'package:dio/dio.dart';
// import 'package:lms_student/core/services/remote/api_consumer.dart';
// import 'package:lms_student/core/services/remote/api_interceptor.dart';
// import 'package:lms_student/core/services/remote/endpoints.dart';
// import 'package:lms_student/core/errors/handle_dio_exception.dart';

// class DioConsumer extends ApiConsumer {
//   final Dio dio;

//   DioConsumer({required this.dio}) {
//     dio.options.baseUrl = EndPoint.baseUrl;
//     dio.interceptors.add(ApiInterceptor());
//     dio.interceptors.add(LogInterceptor(
//       request: true,
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: true,
//       responseBody: true,
//       error: true,
//     ));
//   }

//   @override
//   Future delete(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFromData = false,
//   }) async {
//     try {
//       final response = await dio.delete(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       DioExceptionHandler.handleException(e);
//     }
//   }

//   @override
//   Future get(String path,
//       {Object? data, Map<String, dynamic>? queryParameters}) async {
//     try {
//       final response = await dio.get(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       DioExceptionHandler.handleException(e);
//     }
//   }

//   @override
//   Future patch(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFromData = false,
//   }) async {
//     try {
//       final response = await dio.patch(
//         path,
//         data: isFromData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       DioExceptionHandler.handleException(e);
//     }
//   }

//   @override
//   Future post(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFromData = false,
//   }) async {
//     // try {
//     //   final response = await dio.post(
//     //     path,
//     //     data: isFromData ? FormData.fromMap(data) : data,
//     //     queryParameters: queryParameters,
//     //   );
//     //   return response.data;
//     // } on DioException catch (e) {
//     //   DioExceptionHandler.handleException(e);
//     // }
//      try {
//       final response = await dio.post(
//         path,
//         data: isFormData ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return response; // ✅ لازم يرجع response مش null
//     } on DioException catch (e) {
//       // ✅ نرمي الخطأ عشان الـ repository يمسكه
//       throw e;
//     }
//   }
  
// }

import 'package:dio/dio.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/api_interceptor.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/core/errors/handle_dio_exception.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handleException(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handleException(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handleException(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;  // ✅ نرجع response.data عشان متسق مع باقي الدوال
    } on DioException catch (e) {
      // ✅ نرمي الخطأ عشان الـ repository يمسكه
      throw DioExceptionHandler.handleException(e);
    }
  }
}