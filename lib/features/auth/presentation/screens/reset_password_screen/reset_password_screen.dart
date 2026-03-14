import 'package:flutter/material.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/auth/presentation/screens/reset_password_screen/widgets/reset_password_body.dart';

class ResetPasswordScreen extends StatelessWidget {
      final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body:  ResetPasswordBody(email: email,),
    );
  }
}
