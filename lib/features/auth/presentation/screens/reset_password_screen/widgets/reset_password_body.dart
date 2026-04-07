import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/auth/data/model/reset_password_request_model.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/utils/auth_validation.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class ResetPasswordBody extends StatelessWidget {
  final String email;
  const ResetPasswordBody({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('password_reset_success')),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.go(AppRoutes.loginScreen);
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
                height: 200.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Icon(
                          Icons.terminal_rounded,
                          color: Colors.white,
                          size: 24.w,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          context.tr('reset_password'),
                          style: context.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -35.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 90.h,
                    width: 90.h,
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
                    child: Icon(
                      Icons.lock_reset_rounded,
                      color: context.colorScheme.primary,
                      size: 45.w,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 60.h),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: authBloc.resetPasswordFormKey,
                child: Column(
                  children: [
                    Text(
                      context.tr('create_new_password'),
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      context.tr('new_password_must_be_different'),
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    CustomTextFormField(
                      controller: authBloc.otpController,
                      hintText: context.tr('verification_code'),
                      prefixIcon: Icon(
                        Icons.verified_user_outlined,
                        size: 20.w,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        ///TODO: make it function in utils file
                        if (value == null || value.isEmpty) {
                          return context.tr('verification_code_required');
                        }
                        if (value.length < 6) {
                          return context.tr('enter_valid_6_digit_code');
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: authBloc.newPasswordController,
                      hintText: context.tr('new_password'),
                      isPassword: true,
                      prefixIcon: Icon(Icons.lock_outline_rounded, size: 20.w),
                      validator: (value) => validatePassword(value),
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      controller: authBloc.confirmNewPasswordController,
                      hintText: context.tr('confirm_new_password'),
                      isPassword: true,
                      prefixIcon: Icon(Icons.lock_reset_rounded, size: 20.w),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.tr('please_confirm_password');
                        }
                        if (value != authBloc.newPasswordController.text) {
                          return context.tr('passwords_do_not_match');
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 32.h),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        return CustomPrimaryButton(
                          text: isLoading ? context.tr('updating') : context.tr('update_password'),
                          onTap: isLoading
                              ? null
                              : () {
                                  if (authBloc
                                      .resetPasswordFormKey
                                      .currentState!
                                      .validate()) {
                                    if (authBloc.newPasswordController.text !=
                                        authBloc
                                            .confirmNewPasswordController
                                            .text) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            context.tr('passwords_do_not_match'),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    authBloc.add(
                                      ResetPasswordEvent(
                                        requestModel: ResetPasswordRequestModel(
                                          otp: authBloc.otpController.text
                                              .trim(),
                                          newPassword: authBloc
                                              .newPasswordController
                                              .text
                                              .trim(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    TextButton(
                      onPressed: () => context.go(AppRoutes.loginScreen),
                      child: Text(
                        context.tr('back_to_login'),
                        style: TextStyle(color: context.colorScheme.outline),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
