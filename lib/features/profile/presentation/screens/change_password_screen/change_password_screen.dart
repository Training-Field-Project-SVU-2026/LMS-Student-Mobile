import 'package:flutter/material.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_layout.dart';
import 'package:lms_student/features/profile/presentation/screens/change_password_screen/widgets/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      child: ChangePasswordBody(),
    );
  }
}
