import 'package:lms_student/features/auth/data/model/user_model.dart';

class RegisterResponseModel {
  final String message;
  final UserModel? student;
  final bool isSuccess;

  RegisterResponseModel({
    required this.message,
    this.student,
    required this.isSuccess,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json ,int statusCode) {
   final isSuccess = (statusCode == 201 || statusCode == 200);

    return RegisterResponseModel(
      message: json['message'] ?? '',
      student: json['student'] != null ? UserModel.fromJson(json['student']) : null,
      isSuccess: isSuccess,
    );
  }

  
}

