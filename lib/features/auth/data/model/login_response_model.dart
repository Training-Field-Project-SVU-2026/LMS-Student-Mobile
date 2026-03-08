import 'package:lms_student/features/auth/data/model/user_model.dart';

class LoginResponseModel {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserModel user;
  final bool isSuccess;

  LoginResponseModel({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.isSuccess,
  });

  Map<String, dynamic> toJson() {
  return {
    'message': message,
    'access': accessToken,     
    'refresh': refreshToken,    
    'user': user.toJson(),      
  };
}
  factory LoginResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    final isSuccess = statusCode == 200;
    
    return LoginResponseModel(
      message: json['message'] ?? '',
      accessToken: json['access'] ?? '',
      refreshToken: json['refresh'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      isSuccess: isSuccess,
    );
  }

  factory LoginResponseModel.error(String message) {
    return LoginResponseModel(
      message: message,
      accessToken: '',
      refreshToken: '',
      user: UserModel.fromJson({}),
      isSuccess: false,
    );
  }

  @override
  String toString() {
    return 'LoginResponseModel(message: $message, isSuccess: $isSuccess)';
  }
}