// lib/features/auth/presentation/screens/verify_otp_screen/verify_otp_screen.dart

import 'package:flutter/material.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/auth/presentation/screens/verify_otp_screen/widgets/verify_otp_body.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: VerifyOtpBody(email: email),
    );
  }
}