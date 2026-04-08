import 'package:flutter/material.dart';
import 'package:lms_student/features/auth/presentation/screens/login_screen/widgets/login_body.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      child: LoginBody(),
    );
  }
}