import 'package:json_annotation/json_annotation.dart';
import 'choice_model.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: 'question_name')
  final String questionName;
  @JsonKey(name: 'question_type')
  final String questionType;
  final String slug;
  final List<ChoiceModel> choices;

  QuestionModel({
    required this.questionName,
    required this.questionType,
    required this.slug,
    required this.choices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
