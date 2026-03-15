// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms_student/features/explore/data/model/packages_model.dart';

class PackagesResponseModel {
  bool success;
  int status;
  String message;
  List<PackagesModel> data;

  PackagesResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory PackagesResponseModel.fromJson(Map<String, dynamic> json) {
    return PackagesResponseModel(
      success: json['success'] is bool ? json['success'] : false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<PackagesModel>.from(
              (json['data'] as List).map((x) => PackagesModel.fromJson(x)),
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
