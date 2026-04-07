import 'package:flutter/material.dart';
import 'package:lms_student/features/auth/presentation/screens/verify_otp_screen/widgets/verify_otp_body.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_layout.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: VerifyOtpBody(email: email),
    );
  }
}