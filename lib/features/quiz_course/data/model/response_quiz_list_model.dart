import 'package:json_annotation/json_annotation.dart';
import 'quiz_paginated_data.dart';

part 'response_quiz_list_model.g.dart';

@JsonSerializable()
class ResponseQuizListModel {
  final bool success;
  final int status;
  final String message;
  final QuizPaginatedData data;

  ResponseQuizListModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseQuizListModel.fromJson(Map<String, dynamic> json) => _$ResponseQuizListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseQuizListModelToJson(this);
}
