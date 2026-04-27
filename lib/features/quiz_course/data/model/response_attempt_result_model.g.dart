// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_attempt_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseAttemptResultModel _$ResponseAttemptResultModelFromJson(
  Map<String, dynamic> json,
) => ResponseAttemptResultModel(
  success: json['success'] as bool,
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: AttemptResultModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResponseAttemptResultModelToJson(
  ResponseAttemptResultModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
