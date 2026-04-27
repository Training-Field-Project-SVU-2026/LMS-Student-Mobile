import 'package:json_annotation/json_annotation.dart';

part 'choice_model.g.dart';

@JsonSerializable()
class ChoiceModel {
  @JsonKey(name: 'choice_name')
  final String choiceName;
  final String slug;

  ChoiceModel({
    required this.choiceName,
    required this.slug,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) => _$ChoiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}
