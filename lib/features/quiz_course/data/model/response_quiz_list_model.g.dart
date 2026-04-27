// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_quiz_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseQuizListModel _$ResponseQuizListModelFromJson(
  Map<String, dynamic> json,
) => ResponseQuizListModel(
  success: json['success'] as bool,
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: QuizPaginatedData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResponseQuizListModelToJson(
  ResponseQuizListModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
