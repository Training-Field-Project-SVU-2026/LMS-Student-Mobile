class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String slug;
  final bool? isActive;
  final bool? isVerified;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.slug,
    this.isActive,
    this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      slug: json['slug'] ?? '',
      isActive: json['is_active'] ?? false,
      isVerified: json['is_verified'] ?? false,
    );
  }
}
