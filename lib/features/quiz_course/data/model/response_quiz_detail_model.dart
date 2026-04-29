import 'package:json_annotation/json_annotation.dart';
import 'question_paginated_data.dart';

part 'response_quiz_detail_model.g.dart';

@JsonSerializable()
class ResponseQuizDetailModel {
  final bool success;
  final int status;
  final String message;
  final QuestionPaginatedData data;

  ResponseQuizDetailModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseQuizDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseQuizDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseQuizDetailModelToJson(this);
}
