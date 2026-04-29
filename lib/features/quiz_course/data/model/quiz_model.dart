import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';

enum QuizStatus {
  @JsonValue('not_started')
  notStarted,
  @JsonValue('passed')
  passed,
  @JsonValue('failed')
  failed,
  @JsonValue('can_retry')
  canRetry,
}

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
  final QuizStatus? quizStatus;
  @JsonKey(name: 'best_score')
  final int? bestScore;
  @JsonKey(name: 'passing_percentage')
  final int? passingPercentage;
  final String slug;

  QuizModel({
    required this.quizName,
    required this.courseName,
    required this.totalMark,
    required this.maxAttempts,
    this.attemptsUsed,
    this.quizStatus,
    this.bestScore,
    this.passingPercentage,
    required this.slug,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

  bool get isPassed => quizStatus == QuizStatus.passed;
  bool get isFailed => quizStatus == QuizStatus.failed;
  bool get isCanRetry => quizStatus == QuizStatus.canRetry;
  bool get isNotStarted => quizStatus == QuizStatus.notStarted;
  bool get isMaxAttemptsReached => (attemptsUsed ?? 0) >= maxAttempts;
  bool get canStartOrRetake => !(isFailed || (isPassed && isMaxAttemptsReached));
}
