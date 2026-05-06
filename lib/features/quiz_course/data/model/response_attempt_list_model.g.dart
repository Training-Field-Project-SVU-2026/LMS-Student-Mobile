// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_attempt_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseAttemptListModel _$ResponseAttemptListModelFromJson(
  Map<String, dynamic> json,
) => ResponseAttemptListModel(
  success: json['success'] as bool,
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => AttemptResultModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ResponseAttemptListModelToJson(
  ResponseAttemptListModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
