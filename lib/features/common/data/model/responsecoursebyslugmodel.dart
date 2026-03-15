import 'package:lms_student/features/common/data/model/course_model.dart';

class ResponseCourseBySlugModel {
  final bool success;
  final int? status;
  final String message;
  final CourseModel data;

  ResponseCourseBySlugModel({
    required this.success,
    this.status,
    required this.message,
    required this.data,
  });

  factory ResponseCourseBySlugModel.fromJson(Map<String, dynamic> json) {
    return ResponseCourseBySlugModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: CourseModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}
