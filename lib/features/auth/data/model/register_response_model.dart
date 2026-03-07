import 'package:lms_student/features/auth/data/model/student_model.dart';

class RegisterResponseModel {
  final String message;
  final StudentModel? student;
  final bool isSuccess;

  RegisterResponseModel({
    required this.message,
    this.student,
    required this.isSuccess,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json ,int statusCode) {
   final isSuccess = statusCode == 201;

    return RegisterResponseModel(
      message: json['message'] ?? '',
      student: json['student'] != null ? StudentModel.fromJson(json['student']) : null,
      isSuccess: isSuccess,
    );
  }

  // // in error or will make an error model separately
  // factory RegisterResponseModel.error(String message) {
  //   return RegisterResponseModel(
  //     message: message,
  //     student: null,
  //     isSuccess: false,
  //   );
  // }
}

