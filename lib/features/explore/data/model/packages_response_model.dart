// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms_student/features/explore/data/model/packages_model.dart';

class PackagesResponseModel {
  final bool success;
  final int? status;
  final String message;
  final List<PackagesModel> data;
  final int? totalPackages;
  final int? totalPages;
  final int? currentPage;

  PackagesResponseModel({
    required this.success,
    this.status,
    required this.message,
    required this.data,
    this.totalPackages,
    this.totalPages,
    this.currentPage,
  });

  factory PackagesResponseModel.fromJson(Map<String, dynamic> json) {
    return PackagesResponseModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null && json['data']['packages'] != null
          ? List<PackagesModel>.from(
              json['data']['packages'].map((x) => PackagesModel.fromJson(x)),
            )
          : [],
      totalPackages: json['data'] != null ? json['data']['total_packages'] : null,
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
        'total_packages': totalPackages,
        'total_pages': totalPages,
        'current_page': currentPage,
        'packages': data.map((x) => x.toJson()).toList(),
      },
    };
  }
}
