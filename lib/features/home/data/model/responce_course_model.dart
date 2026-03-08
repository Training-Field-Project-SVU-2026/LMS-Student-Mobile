import 'package:lms_student/features/home/data/model/course_model.dart';

class ResponseCourseModel {
  final bool success;
  final int? status;
  final String message;
  final List<CourseModel> data;

  ResponseCourseModel({
    required this.success,
    this.status,
    required this.message,
    required this.data,
  });

  factory ResponseCourseModel.fromJson(Map<String, dynamic> json) {
    return ResponseCourseModel(
      success: json['success'] ?? false, // لو null خد false
      status: json['status'] ?? 0, // لو null خد 0
      message: json['message'] ?? '', // لو null خد ''
      data: json['data'] != null
          ? List<CourseModel>.from(
              json['data'].map((x) => CourseModel.fromJson(x)),
            )
          : [], // لو null خد List فاضية
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}
