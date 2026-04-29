import 'package:json_annotation/json_annotation.dart';
import 'question_model.dart';

part 'question_paginated_data.g.dart';

@JsonSerializable()
class QuestionPaginatedData {
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'total_quizzes')
  final int totalQuestions;
  @JsonKey(name: 'quizzes')
  final List<QuestionModel> questions;

  QuestionPaginatedData({
    required this.totalPages,
    required this.currentPage,
    required this.totalQuestions,
    required this.questions,
  });

  factory QuestionPaginatedData.fromJson(Map<String, dynamic> json) => _$QuestionPaginatedDataFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionPaginatedDataToJson(this);
}
