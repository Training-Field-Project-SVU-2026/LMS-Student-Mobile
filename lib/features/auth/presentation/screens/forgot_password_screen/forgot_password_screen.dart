// lib/features/auth/presentation/screens/forget_password_screen/forget_password_screen.dart

import 'package:flutter/material.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/auth/presentation/screens/forgot_password_screen/widgets/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: const ForgotPasswordBody(),
    );
  }
}