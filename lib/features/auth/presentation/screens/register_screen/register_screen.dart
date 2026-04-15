import 'package:flutter/material.dart';
import 'package:lms_student/features/auth/presentation/screens/register_screen/widgets/register_body.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_layout.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthLayout(
        child: RegisterBody(),
      ),
    );
  }
}

