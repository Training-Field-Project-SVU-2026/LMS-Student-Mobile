import 'package:lms_student/features/common/data/model/course_model.dart';

class PackagesModel {
  final String title;
  final String slug;
  final double price;
  final String createdAt;
  final String instructorName;
  final List<CourseModel>? courses;
  final List<String> categories;

  PackagesModel({
    required this.title,
    required this.slug,
    required this.price,
    required this.createdAt,
    required this.instructorName,
    this.courses,
    required this.categories,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) {
    return PackagesModel(
      title: json['title']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
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
          : [],
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
      'price': price.toString(),
      'created_at': createdAt,
      'instructor_name': instructorName,
      'categories': categories,
      'courses': [] ?? courses.map((course) => course.toJson()).toList(),
    };
  }
}
