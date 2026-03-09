// lib/features/auth/presentation/screens/forget_password_screen/forget_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/di/service_locator.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بنستخدم BlocProvider هنا عشان نوفر الـ AuthBloc لشاشة نسيان كلمة السر
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        // استخدمت context.colorScheme.surface عشان يماشي لغة التصميم في المشروع
        backgroundColor: context.colorScheme.surface,
        body: const ForgotPasswordBody(),
      ),
    );
  }
}