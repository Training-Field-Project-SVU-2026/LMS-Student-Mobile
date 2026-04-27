// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
  quizName: json['quiz_name'] as String,
  courseName: json['course_name'] as String,
  totalMark: (json['total_mark'] as num).toInt(),
  maxAttempts: (json['max_attempts'] as num).toInt(),
  attemptsUsed: (json['attempts_used'] as num?)?.toInt(),
  quizStatus: json['quiz_status'] as String?,
  bestScore: (json['best_score'] as num?)?.toInt(),
  slug: json['slug'] as String,
);

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
  'quiz_name': instance.quizName,
  'course_name': instance.courseName,
  'total_mark': instance.totalMark,
  'max_attempts': instance.maxAttempts,
  'attempts_used': instance.attemptsUsed,
  'quiz_status': instance.quizStatus,
  'best_score': instance.bestScore,
  'slug': instance.slug,
};
