import 'package:json_annotation/json_annotation.dart';
import 'attempt_result_model.dart';

part 'response_attempt_list_model.g.dart';

@JsonSerializable()
class ResponseAttemptListModel {
  final bool success;
  final int status;
  final String message;
  final List<AttemptResultModel> data;

  ResponseAttemptListModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseAttemptListModel.fromJson(Map<String, dynamic> json) => _$ResponseAttemptListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseAttemptListModelToJson(this);
}
