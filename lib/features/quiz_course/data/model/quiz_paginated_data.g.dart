// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_paginated_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizPaginatedData _$QuizPaginatedDataFromJson(Map<String, dynamic> json) =>
    QuizPaginatedData(
      totalPages: (json['total_pages'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      totalQuizzes: (json['total_quizzes'] as num).toInt(),
      quizzes: (json['quizzes'] as List<dynamic>)
          .map((e) => QuizModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistics: json['statistics'] == null
          ? null
          : QuizStatisticsModel.fromJson(
              json['statistics'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$QuizPaginatedDataToJson(QuizPaginatedData instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'total_quizzes': instance.totalQuizzes,
      'quizzes': instance.quizzes,
      'statistics': instance.statistics,
    };
