import 'package:flutter/material.dart';
import 'package:lms_student/features/auth/presentation/screens/forgot_password_screen/widgets/forgot_password_body.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_layout.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      child: ForgotPasswordBody(),
    );
  }
}