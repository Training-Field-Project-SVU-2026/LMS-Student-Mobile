// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_quiz_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseQuizDetailModel _$ResponseQuizDetailModelFromJson(
  Map<String, dynamic> json,
) => ResponseQuizDetailModel(
  success: json['success'] as bool,
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: QuestionPaginatedData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResponseQuizDetailModelToJson(
  ResponseQuizDetailModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
