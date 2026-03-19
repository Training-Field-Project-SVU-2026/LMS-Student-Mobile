import 'package:lms_student/features/explore/data/model/packages_model.dart';

class PackageBySlugResponseModel {
  final bool success;
  final int? status;
  final String message;
  final PackagesModel data;

  PackageBySlugResponseModel({
    required this.success,
    this.status,
    required this.message,
    required this.data,
  });

  factory PackageBySlugResponseModel.fromJson(Map<String, dynamic> json) {
    return PackageBySlugResponseModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: PackagesModel.fromJson(json['data'] as Map<String, dynamic>),
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
