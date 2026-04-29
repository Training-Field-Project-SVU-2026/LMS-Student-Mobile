import 'package:json_annotation/json_annotation.dart';
import 'quiz_model.dart';

part 'quiz_paginated_data.g.dart';

@JsonSerializable()
class QuizPaginatedData {
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'total_quizzes')
  final int totalQuizzes;
  final List<QuizModel> quizzes;

  QuizPaginatedData({
    required this.totalPages,
    required this.currentPage,
    required this.totalQuizzes,
    required this.quizzes,
  });

  factory QuizPaginatedData.fromJson(Map<String, dynamic> json) => _$QuizPaginatedDataFromJson(json);
  Map<String, dynamic> toJson() => _$QuizPaginatedDataToJson(this);
}
