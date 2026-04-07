import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';

class EnrollCourseModel {
  final String success;
  final int statusCode;
  final String message;
  final List<CourseModel> data;
  final int? totalPages;
  final int? currentPage;
  EnrollCourseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.totalPages,
    this.currentPage,
    required this.data,
  });

  factory EnrollCourseModel.fromJson(Map<String, dynamic> json) {
    return EnrollCourseModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'].map((x) => CourseModel.fromJson(x)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}
