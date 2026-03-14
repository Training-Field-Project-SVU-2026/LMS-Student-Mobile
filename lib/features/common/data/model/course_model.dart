class CourseModel {
  int? id;
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
  double? avgRating;
  int? ratingsCount;
  int? studentsCount;

  CourseModel({
    this.id,
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
    this.avgRating,
    this.ratingsCount,
    this.studentsCount,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price']?.toString() ?? '0.0'),
      category: json['category'],
      level: json['level'] ?? '',
      image: json['image'],
      createdAt: json['created_at'],
      isActive: json['is_active'],
      instructorName: json['instructor_name'] ?? '',
      avgRating: json['avg_rating'] != null ? double.parse(json['avg_rating'].toString()) : null,
      ratingsCount: json['ratings_count'],
      studentsCount: json['students_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      'avg_rating': avgRating,
      'ratings_count': ratingsCount,
      'students_count': studentsCount,
    };
  }
}
