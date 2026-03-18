import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';

class PackagesModel {
  final String title;
  final String slug;
  final String description;
  final double price;
  final String createdAt;
  final String instructorName;
  final List<CourseModel>? courses;
  final int coursesCount;
  final List<String> categories;

  PackagesModel({
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.instructorName,
    this.courses,
    required this.coursesCount,
    required this.categories,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) {
    return PackagesModel(
      title: json['title']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price'] != null
          ? (json['price'] is num
              ? (json['price'] as num).toDouble()
              : double.tryParse(json['price'].toString()) ?? 0.0)
          : 0.0,
      createdAt: json['created_at']?.toString() ?? '',
      instructorName: json['instructor_name']?.toString() ?? '',
      courses: json['courses'] != null && json['courses'] is List
          ? List<CourseModel>.from(
              (json['courses'] as List).map(
                (x) => CourseModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      coursesCount: json['courses_count'] is int
          ? json['courses_count'] as int
          : int.tryParse(json['courses_count']?.toString() ?? '0') ?? 0,
      categories: json['categories'] != null && json['categories'] is List
          ? List<String>.from(
              (json['categories'] as List).map((e) => e.toString()),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
      'description': description,
      'price': price.toString(),
      'created_at': createdAt,
      'instructor_name': instructorName,
      'courses': courses?.map((course) => course.toJson()).toList(),
      'courses_count': coursesCount,
      'categories': categories,
    };
  }
}
