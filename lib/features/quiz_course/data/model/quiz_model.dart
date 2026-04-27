import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel {
  @JsonKey(name: 'quiz_name')
  final String quizName;
  @JsonKey(name: 'course_name')
  final String courseName;
  @JsonKey(name: 'total_mark')
  final int totalMark;
  @JsonKey(name: 'max_attempts')
  final int maxAttempts;
  @JsonKey(name: 'attempts_used')
  final int? attemptsUsed;
  @JsonKey(name: 'quiz_status')
  final String? quizStatus;
  @JsonKey(name: 'best_score')
  final int? bestScore;
  final String slug;

  QuizModel({
    required this.quizName,
    required this.courseName,
    required this.totalMark,
    required this.maxAttempts,
    this.attemptsUsed,
    this.quizStatus,
    this.bestScore,
    required this.slug,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);
}
