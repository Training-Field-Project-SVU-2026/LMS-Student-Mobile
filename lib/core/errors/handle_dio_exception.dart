import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handleException(DioException e) {
    
    // server error with response 
    if (e.response != null) {
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      
      // bring message from server 
      final serverMessage = e.response?.data['message'] ?? 'Registration failed';
      
      switch (e.response?.statusCode) {
        case 400:
          return 'Bad request: $serverMessage';
        case 401:
          return 'Unauthorized: $serverMessage';
        case 403:
          return 'Forbidden: $serverMessage';
        case 404:
          return 'Not found: $serverMessage';
        case 409:
          return 'Conflict: $serverMessage'; // زي الايميل موجود
        case 422:
          return 'Validation error: $serverMessage';
        case 500:
          return 'Server error, please try again later';
        case 502:
        case 503:
          return 'Service unavailable, please try again later';
        default:
          return serverMessage;
      }
    }
    
    // network error or other dio exceptions without response
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        return 'No internet connection. Please check your network.';
        
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Server is taking too long to respond. Please try again.';
        
      case DioExceptionType.cancel:
        return 'Request was cancelled';
        
      case DioExceptionType.badCertificate:
        return 'Security certificate error';
        
      case DioExceptionType.badResponse:
        return 'Unexpected response from server';
        
      default:
        return 'Network error: ${e.message}';
    }
  }
}