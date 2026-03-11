import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_toggle_switch.dart';
import 'package:lms_student/features/auth/utils/auth_validation.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('verification_code_sent')),
              backgroundColor: Colors.green,
            ),
          );

          context.go(
            AppRoutes.verifyOtpScreen,
            extra: {
              'email': authBloc.emailController.text.trim(),
              'source': 'register',
            },
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: authBloc.registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.code,
                        color: context.colorScheme.primary,
                        size: 30.w,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  Text(
                    context.tr('start_your_journey'),
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.tr('create_account_commit'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  SizedBox(height: 20.h),
                  AuthToggleSwitch(isLogin: false),
                  SizedBox(height: 30.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: authBloc.firstNameController,
                          hintText: context.tr('first_name'),
                          prefixIcon: Icon(Icons.person_outline, size: 22.w),
                          validator: (value) => validateFirstName(value),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: CustomTextFormField(
                          controller: authBloc.lastNameController,
                          hintText: context.tr('last_name'),
                          prefixIcon: Icon(Icons.person_outline, size: 22.w),
                          validator: (value) => validateLastName(value),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: authBloc.emailController,
                    hintText: context.tr('email_address'),
                    prefixIcon: Icon(Icons.email_outlined, size: 22.w),
                    validator: (value) => validateEmail(value),
                  ),

                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: authBloc.passwordController,
                    hintText: context.tr('password'),
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                    validator: (value) => validatePassword(value),
                  ),

                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: authBloc.confirmPasswordController,
                    hintText: context.tr('confirm_password'),
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.tr('please_confirm_password');
                      }
                      if (value != authBloc.passwordController.text) {
                        return context.tr('passwords_do_not_match');
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 30.h),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;

                      return Align(
                        alignment: Alignment.center,
                        child: CustomPrimaryButton(
                          text: isLoading
                              ? context.tr('creating_account')
                              : context.tr('create_account'),
                          onTap: isLoading
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  context.read<AuthBloc>().add(RegisterEvent());
                                  // context.go(
                                  //   AppRoutes.verifyOtpScreen,
                                  //   extra: {
                                  //     "email": "mayarabdelrahim22@gmail.com",
                                  //   },
                                  // );
                                },
                          suffixIcon: isLoading
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: CircularProgressIndicator(
                                    color: context.colorScheme.onPrimary,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  Icons.arrow_forward,
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onPrimary,
                                  size: 20.w,
                                ),
                          width: 287.w,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 30.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: context.colorScheme.outlineVariant
                                .withValues(alpha: 0.15),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            context.tr('or'),
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: context.colorScheme.outlineVariant
                                .withValues(alpha: 0.15),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Align(
                    child: CustomOutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        side: BorderSide(color: context.colorScheme.outline),
                      ),
                      width: 287.w,
                      text: context.tr('continue_as_guest'),
                      onTap: () {
                        context.go(AppRoutes.homeScreen);
                      },
                    ),
                  ),

                  SizedBox(height: 100.h),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.go(AppRoutes.loginScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: context.tr('already_have_account'),
                          style: context.textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: context.tr('sign_in'),
                              style: TextStyle(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
