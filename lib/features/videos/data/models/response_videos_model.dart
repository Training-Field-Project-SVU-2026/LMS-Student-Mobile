import 'package:lms_student/features/videos/data/models/video_model.dart';

class ResponseVideosModel {
  final bool success;
  final int? status;
  final String message;
  final List<VideoModel> data;

  ResponseVideosModel({
    required this.success,
    this.status,
    required this.message,
    required this.data,
  });

  factory ResponseVideosModel.fromJson(Map<String, dynamic> json) {
    return ResponseVideosModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<VideoModel>.from(
              json['data'].map((x) => VideoModel.fromJson(x)),
            )
          : [],
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
