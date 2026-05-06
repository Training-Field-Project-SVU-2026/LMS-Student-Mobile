// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_paginated_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionPaginatedData _$QuestionPaginatedDataFromJson(
  Map<String, dynamic> json,
) => QuestionPaginatedData(
  totalPages: (json['total_pages'] as num).toInt(),
  currentPage: (json['current_page'] as num).toInt(),
  totalQuestions: (json['total_quizzes'] as num).toInt(),
  questions: (json['quizzes'] as List<dynamic>)
      .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuestionPaginatedDataToJson(
  QuestionPaginatedData instance,
) => <String, dynamic>{
  'total_pages': instance.totalPages,
  'current_page': instance.currentPage,
  'total_quizzes': instance.totalQuestions,
  'quizzes': instance.questions,
};
