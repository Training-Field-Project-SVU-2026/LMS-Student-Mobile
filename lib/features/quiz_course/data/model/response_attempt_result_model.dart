import 'package:json_annotation/json_annotation.dart';
import 'attempt_result_model.dart';

part 'response_attempt_result_model.g.dart';

@JsonSerializable()
class ResponseAttemptResultModel {
  final bool success;
  final int status;
  final String message;
  final AttemptResultModel data;

  ResponseAttemptResultModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseAttemptResultModel.fromJson(Map<String, dynamic> json) => _$ResponseAttemptResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseAttemptResultModelToJson(this);
}
