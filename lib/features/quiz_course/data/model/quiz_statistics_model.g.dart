// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizStatisticsModel _$QuizStatisticsModelFromJson(Map<String, dynamic> json) =>
    QuizStatisticsModel(
      overallBestScore: json['overall_best_score'] as String,
      completedQuizzes: json['completed_quizzes'] as String,
    );

Map<String, dynamic> _$QuizStatisticsModelToJson(
  QuizStatisticsModel instance,
) => <String, dynamic>{
  'overall_best_score': instance.overallBestScore,
  'completed_quizzes': instance.completedQuizzes,
};
