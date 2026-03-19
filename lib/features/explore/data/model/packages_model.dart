import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';

class PackagesModel {
  final String title;
  final String instructorName;
  final String slug;
  final String description;
  final double price;
  final String createdAt;
  final int coursesCount;
  final double avgRating;
  final List<String> categories;
  final List<String> courseSlugs;
  final List<CourseModel>? courses;

  PackagesModel({
    required this.title,
    required this.instructorName,
    required this.slug,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.coursesCount,
    required this.avgRating,
    required this.categories,
    required this.courseSlugs,
    this.courses,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) {
    return PackagesModel(
      title: json['title']?.toString() ?? '',
      instructorName: json['instructor_name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      createdAt: json['created_at']?.toString() ?? '',
      coursesCount: int.tryParse(json['courses_count']?.toString() ?? '0') ?? 0,
      avgRating:
          double.tryParse(json['avg_rating']?.toString() ?? '0.0') ?? 0.0,
      categories: json['categories'] != null && json['categories'] is List
          ? List<String>.from(
              (json['categories'] as List).map((e) => e.toString()),
            )
          : [],
      courseSlugs: json['course_slugs'] != null && json['course_slugs'] is List
          ? List<String>.from(
              (json['course_slugs'] as List).map((e) => e.toString()),
            )
          : [],
      courses: json['courses'] != null && json['courses'] is List
          ? List<CourseModel>.from(
              (json['courses'] as List).map(
                (x) => CourseModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'instructor_name': instructorName,
      'slug': slug,
      'description': description,
      'price': price.toString(),
      'created_at': createdAt,
      'courses_count': coursesCount,
      'avg_rating': avgRating.toString(),
      'categories': categories,
      'course_slugs': courseSlugs,
      'courses': courses?.map((course) => course.toJson()).toList(),
    };
  }
}
