import 'package:json_annotation/json_annotation.dart';

// part 'quiz_course_model.g.dart';

@JsonSerializable()
class QuizCourseModel {
  final String image;
  final String name;

  QuizCourseModel({required this.image, required this.name});

  // factory QuizCourseModel.fromJson(Map<String, dynamic> json) => _$QuizCourseModelFromJson(json);
  // Map<String, dynamic> toJson() => _$QuizCourseModelToJson(this);
}