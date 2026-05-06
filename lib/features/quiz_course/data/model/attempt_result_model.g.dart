// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttemptResultModel _$AttemptResultModelFromJson(Map<String, dynamic> json) =>
    AttemptResultModel(
      quizName: json['quiz_name'] as String?,
      totalMark: (json['total_mark'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      percentage: (json['percentage'] as num?)?.toInt(),
      passingPercentage: (json['passing_percentage'] as num?)?.toInt(),
      status: json['status'] as String,
      attemptNumber: (json['attempt_number'] as num).toInt(),
      maxAttempts: (json['max_attempts'] as num?)?.toInt(),
      attemptDate: json['attempt_date'] as String?,
      feedback: json['feedback'] as String?,
      passed: json['passed'] as bool?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => SelectedAnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttemptResultModelToJson(AttemptResultModel instance) =>
    <String, dynamic>{
      'quiz_name': instance.quizName,
      'total_mark': instance.totalMark,
      'score': instance.score,
      'percentage': instance.percentage,
      'passing_percentage': instance.passingPercentage,
      'status': instance.status,
      'attempt_number': instance.attemptNumber,
      'max_attempts': instance.maxAttempts,
      'attempt_date': instance.attemptDate,
      'feedback': instance.feedback,
      'passed': instance.passed,
      'answers': instance.answers,
    };

SelectedAnswerModel _$SelectedAnswerModelFromJson(Map<String, dynamic> json) =>
    SelectedAnswerModel(
      question: json['question'] as String,
      questionSlug: json['question_slug'] as String,
      questionType: json['question_type'] as String,
      selectedChoices: (json['selected_choices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$SelectedAnswerModelToJson(
  SelectedAnswerModel instance,
) => <String, dynamic>{
  'question': instance.question,
  'question_slug': instance.questionSlug,
  'question_type': instance.questionType,
  'selected_choices': instance.selectedChoices,
  'is_correct': instance.isCorrect,
};
