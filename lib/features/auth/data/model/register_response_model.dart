import 'package:lms_student/core/common_logic/data/model/user_model.dart';

class RegisterResponseModel {
  final String message;
  final UserModel? student;

  RegisterResponseModel({
    required this.message,
    this.student,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {

    return RegisterResponseModel(
      message: json['message'] ?? '',
      student: json['student'] != null ? UserModel.fromJson(json['student']) : null,
    );
  }

  
}
