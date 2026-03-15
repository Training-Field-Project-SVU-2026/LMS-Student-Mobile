// ignore_for_file: public_member_api_docs, sort_constructors_first
class CourseModel {
  // int? id;
  String title;
  String slug;
  String description;
  double price;
  String? category;
  String level;
  String? image;
  String? createdAt;
  bool? isActive;
  String instructorName;
  String instructorBio;
  String? instructorImage;
  double? avgRating;
  int? ratingsCount;
  int? studentsCount;
  // int? courseCount;
  // TODO :: we need from omniya add it

  CourseModel({
    // this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    this.category,
    required this.level,
    this.image,
    this.createdAt,
    this.isActive,
    required this.instructorName,
    required this.instructorBio,
    this.instructorImage,
    this.avgRating,
    this.ratingsCount,
    this.studentsCount,
    // this.courseCount,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    final String firstName = json['instructor_firstname'] ?? '';
    final String lastName = json['instructor_lastname'] ?? '';
    final String fullName = '$firstName $lastName'.trim();

    return CourseModel(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price']?.toString() ?? '0.0'),
      category: json['category'],
      level: json['level'] ?? '',
      image: json['image'],
      createdAt: json['created_at'],
      isActive: json['is_active'],
      instructorName: fullName.isEmpty
          ? (json['instructor_name'] ?? '')
          : fullName,
      instructorImage: json['instructor_image'],
      avgRating: double.tryParse(json['avg_rating']?.toString() ?? '') ?? 500,
      ratingsCount:
          int.tryParse(json['ratings_count']?.toString() ?? '') ?? 500,
      // courseCount: int.tryParse(json['ratings_count']?.toString() ?? '') ?? 500,
      studentsCount:
          int.tryParse(json['course_count']?.toString() ?? '') ?? 500,
      instructorBio: json['instructor_bio'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'price': price.toString(),
      'category': category,
      'level': level,
      'image': image,
      'created_at': createdAt,
      'is_active': isActive,
      'instructor_name': instructorName,
      'instructor_bio': instructorBio,
      'instructor_image': instructorImage,
      'avg_rating': avgRating.toString(),
      'ratings_count': ratingsCount.toString(),
      'students_count': studentsCount.toString(),
      // 'course_count': courseCount.toString(),
    };
  }
}
