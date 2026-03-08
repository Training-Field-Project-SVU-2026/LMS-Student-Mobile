class CourseModel {
  int? id;
  String title;
  String slug;
  String description;
  double price; // حولناها لـ double
  String? category;
  String level;
  String? image; // حولناها لـ nullable
  String? createdAt;
  bool? isActive;
  String instructorName;

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
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      price: double.parse(json['price']), // تحويل لـ double
      category: json['category'],
      level: json['level'],
      image: json['image'],
      createdAt: json['created_at'],
      isActive: json['is_active'],
      instructorName: json['instructor_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'price': price.toString(), // لو محتفظ بالـ price كـ double
      'category': category,
      'level': level,
      'image': image,
      'created_at': createdAt,
      'is_active': isActive,
      'instructor_name': instructorName,
    };
  }
}
