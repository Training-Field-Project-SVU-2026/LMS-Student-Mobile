import 'package:lms_student/features/auth/data/model/user_model.dart';

class LoginResponseModel {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponseModel({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': {
        'access': accessToken,
        'refresh': refreshToken,
        'user': user.toJson(),
      }
    };
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return LoginResponseModel(
      message: json['message'] ?? '',
      accessToken: data['access'] ?? '',
      refreshToken: data['refresh'] ?? '',
      user: UserModel.fromJson(data['user'] ?? {}),
    );
  }

  factory LoginResponseModel.error(String message) {
    return LoginResponseModel(
      message: message,
      accessToken: '',
      refreshToken: '',
      user: UserModel.fromJson({}),
    );
  }

  @override
  String toString() {
    return 'LoginResponseModel(message: $message)';
  }
}
