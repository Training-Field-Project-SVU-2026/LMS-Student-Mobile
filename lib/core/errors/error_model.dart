
// import 'package:lms_student/core/services/remote/endpoints.dart';

// class ErrorModel {
//   final int status;
//   final String? errorMessage;

//   ErrorModel({this.status =0,required this.errorMessage});
//   factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
//     return ErrorModel(
//       // status: jsonData[ApiKey.statusCode],
//       errorMessage: jsonData[ApiKey.message],
//     );
//   }
// }

import 'package:lms_student/core/services/remote/endpoints.dart';

class ErrorModel {
  final String message;  // بس message, مش status

  ErrorModel({required this.message});
  
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      message: jsonData[ApiKey.message] ?? 'Unknown error',
    );
  }
}