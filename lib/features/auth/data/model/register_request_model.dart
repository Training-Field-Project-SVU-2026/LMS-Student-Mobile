class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

// لما نبعته لل api 
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }

  // // لو عايزة اعمل ابديت لحاجة معينة من غير ما اغير الباقي
  // RegisterRequestModel copyWith({
  //   String? firstName,
  //   String? lastName,
  //   String? email,
  //   String? password,
  // }) 
  // {
  //   return RegisterRequestModel(
  //     firstName: firstName ?? this.firstName,
  //     lastName: lastName ?? this.lastName,
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //   );
  // }
}