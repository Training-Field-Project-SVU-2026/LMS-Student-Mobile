import 'package:json_annotation/json_annotation.dart';

part 'attempt_result_model.g.dart';

@JsonSerializable()
class AttemptResultModel {
  @JsonKey(name: 'quiz_name')
  final String? quizName;
  @JsonKey(name: 'total_mark')
  final int totalMark;
  final int score;
  final int? percentage;
  final String status;
  @JsonKey(name: 'attempt_number')
  final int attemptNumber;
  @JsonKey(name: 'max_attempts')
  final int? maxAttempts;
  @JsonKey(name: 'attempt_date')
  final String? attemptDate;
  final String? feedback;
  final bool? passed;
  final List<SelectedAnswerModel>? answers;

  AttemptResultModel({
    this.quizName,
    required this.totalMark,
    required this.score,
    this.percentage,
    required this.status,
    required this.attemptNumber,
    this.maxAttempts,
    this.attemptDate,
    this.feedback,
    this.passed,
    this.answers,
  });

  factory AttemptResultModel.fromJson(Map<String, dynamic> json) =>
      _$AttemptResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttemptResultModelToJson(this);
}

@JsonSerializable()
class SelectedAnswerModel {
  final String question;
  @JsonKey(name: 'question_slug')
  final String questionSlug;
  @JsonKey(name: 'question_type')
  final String questionType;
  @JsonKey(name: 'selected_choices')
  final List<String> selectedChoices;
  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  SelectedAnswerModel({
    required this.question,
    required this.questionSlug,
    required this.questionType,
    required this.selectedChoices,
    required this.isCorrect,
  });

  factory SelectedAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$SelectedAnswerModelFromJson(json);
  Map<String, dynamic> toJson() => _$SelectedAnswerModelToJson(this);
}
