import 'package:json_annotation/json_annotation.dart';

part 'quiz_statistics_model.g.dart';

@JsonSerializable()
class QuizStatisticsModel {
  @JsonKey(name: 'overall_best_score')
  final String overallBestScore;
  @JsonKey(name: 'completed_quizzes')
  final String completedQuizzes;

  QuizStatisticsModel({
    required this.overallBestScore,
    required this.completedQuizzes,
  });

  factory QuizStatisticsModel.fromJson(Map<String, dynamic> json) => _$QuizStatisticsModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizStatisticsModelToJson(this);
}
