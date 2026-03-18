import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';

class ResponseCourseModel {
  final bool success;
  final int? status;
  final String message;
  final List<CourseModel> data;
  final int? totalCourses;
  final int? totalPages;
  final int? currentPage;

  ResponseCourseModel({
    required this.success,
    this.status,
    required this.message,
    required this.data,
    this.totalCourses,
    this.totalPages,
    this.currentPage,
  });

  factory ResponseCourseModel.fromJson(Map<String, dynamic> json) {
    return ResponseCourseModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null && json['data']['courses'] != null
          ? List<CourseModel>.from(
              json['data']['courses'].map((x) => CourseModel.fromJson(x)),
            )
          : [],
      totalCourses: json['data'] != null ? json['data']['total_courses'] : null,
      totalPages: json['data'] != null ? json['data']['total_pages'] : null,
      currentPage: json['data'] != null ? json['data']['current_page'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': {
        'total_courses': totalCourses,
        'total_pages': totalPages,
        'current_page': currentPage,
        'courses': data.map((x) => x.toJson()).toList(),
      },
    };
  }
}
