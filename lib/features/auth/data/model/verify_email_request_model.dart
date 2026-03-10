class VerifyEmailRequestModel {
  final String email;
  final String otp;

  VerifyEmailRequestModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }

  factory VerifyEmailRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyEmailRequestModel(
      email: json['email'] ?? '',
      otp: json['otp'] ?? '',
    );
  }
}
