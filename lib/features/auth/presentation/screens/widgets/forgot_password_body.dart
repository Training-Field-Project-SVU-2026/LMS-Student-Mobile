import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/utils/auth_validation.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.secondary,
            ),
          );

          context.go(
            AppRoutes.resetPasswordScreen,
            extra: {
              'email': authBloc.emailController.text.trim(),
            },
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 280.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      // Logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.terminal_rounded,
                            color: Colors.white,
                            size: 24.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "COMMIT MA3ANA",
                            style: context.textTheme.labelLarge?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              letterSpacing: 2,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -40.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 120.h,
                    width: 120.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Image.asset(
                        'assets/images/elkott.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.lock_reset_rounded,
                          color: context.colorScheme.primary,
                          size: 50.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 60.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Form(
                key: authBloc.forgetPasswordFormKey,
                child: Column(
                  children: [
                    Text(
                      "Forgot Password?",
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "No worries! Enter your email and we will send you an otp.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    CustomTextFormField(
                      controller: authBloc.emailController,
                      hintText: 'Enter your email',
                      prefixIcon: Icon(
                        Icons.alternate_email_rounded,
                        color: context.colorScheme.primary,
                        size: 20.w,
                      ),
                      validator: (value) => validateEmail(value),
                    ),

                    SizedBox(height: 32.h),

                    // Button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        return CustomPrimaryButton(
                          text: isLoading ? 'Sending...' : 'Send OTP',
                          onTap: isLoading
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  authBloc.add(
                                    ForgotPasswordEvent(
                                      email: authBloc.emailController.text
                                          .trim(),
                                    ),
                                  );
                                },
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Back Button
                    TextButton.icon(
                      onPressed: () => context.go(AppRoutes.loginScreen),
                      icon: Icon(Icons.arrow_back_ios_new_rounded, size: 14.w),
                      label: const Text("Back to Login"),
                      style: TextButton.styleFrom(
                        foregroundColor: context.colorScheme.outline,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer بسيط جداً
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Text(
              "Commit Ma3ana • Build Consistency",
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
