// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttemptResultModel _$AttemptResultModelFromJson(Map<String, dynamic> json) =>
    AttemptResultModel(
      totalMark: (json['total_mark'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      percentage: (json['percentage'] as num?)?.toInt(),
      status: json['status'] as String,
      attemptNumber: (json['attempt_number'] as num).toInt(),
      feedback: json['feedback'] as String?,
      passed: json['passed'] as bool?,
    );

Map<String, dynamic> _$AttemptResultModelToJson(AttemptResultModel instance) =>
    <String, dynamic>{
      'total_mark': instance.totalMark,
      'score': instance.score,
      'percentage': instance.percentage,
      'status': instance.status,
      'attempt_number': instance.attemptNumber,
      'feedback': instance.feedback,
      'passed': instance.passed,
    };
