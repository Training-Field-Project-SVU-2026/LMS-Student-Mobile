import 'package:flutter/material.dart';
import 'package:lms_student/features/auth/presentation/screens/reset_password_screen/widgets/reset_password_body.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayout(
        child: ResetPasswordBody(email: email),
      ),
    );
  }
}
