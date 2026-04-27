import 'package:json_annotation/json_annotation.dart';

part 'attempt_result_model.g.dart';

@JsonSerializable()
class AttemptResultModel {
  @JsonKey(name: 'total_mark')
  final int totalMark;
  final int score;
  final int? percentage;
  final String status;
  @JsonKey(name: 'attempt_number')
  final int attemptNumber;
  final String? feedback;
  final bool? passed;

  AttemptResultModel({
    required this.totalMark,
    required this.score,
    this.percentage,
    required this.status,
    required this.attemptNumber,
    this.feedback,
    this.passed,
  });

  factory AttemptResultModel.fromJson(Map<String, dynamic> json) => _$AttemptResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttemptResultModelToJson(this);
}
