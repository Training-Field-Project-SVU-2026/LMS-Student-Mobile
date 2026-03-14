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

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('login_success')),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRoutes.homeScreenAfterLogin);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: authBloc.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),

                Center(
                  child: Column(
                    children: [
                      // Container(
                      //   padding: EdgeInsets.all(10.w),
                      //   decoration: BoxDecoration(
                      //     color: context.colorScheme.primary.withValues(alpha: 0.1),
                      //     borderRadius: BorderRadius.circular(12.r),
                      //   ),
                      //   child: Icon(
                      //     Icons.code,
                      //     color: context.colorScheme.primary,
                      //     size: 35.w,
                      //   ),
                      // ),
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Image.network(
                          "https://i.pinimg.com/736x/13/6a/40/136a404d2a248920b807f8929f6a1b5b.jpg",
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr('eight_names_app'),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),
                Text(
                  context.tr('welcome_back'),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  context.tr('sign_in_continue'),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 24.h),

                AuthToggleSwitch(isLogin: true),

                SizedBox(height: 25.h),
                CustomTextFormField(
                  controller: authBloc.emailController,
                  hintText: context.tr('email_address'),
                  prefixIcon: Icon(Icons.email_outlined, size: 22.w),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validateEmail(value),
                ),

                SizedBox(height: 16.h),

                CustomTextFormField(
                  controller: authBloc.passwordController,
                  hintText: context.tr('password'),
                  isPassword: true,
                  prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                  validator: (value) => validatePassword(value),
                  keyboardType: TextInputType.visiblePassword,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.go(AppRoutes.forgotPasswordScreen);
                    },
                    child: Text(
                      context.tr('forgot_password_question'),
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return CustomPrimaryButton(
                      text: isLoading ? context.tr('signing_in') : context.tr('sign_in'),
                      onTap: isLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(LoginEvent());
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
                              color: context.colorScheme.surface,
                              size: 20.w,
                            ),
                    );
                  },
                ),

                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: context.colorScheme.outlineVariant.withValues(
                            alpha: 0.15,
                          ),
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
                          color: context.colorScheme.outlineVariant.withValues(
                            alpha: 0.15,
                          ),
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
                    width: 400.w,
                    text: context.tr('continue_as_guest'),
                    onTap: () {
                      context.go(AppRoutes.homeScreen);
                    },
                  ),
                ),

                SizedBox(height: 50.h),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.go(AppRoutes.registerScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: context.tr('dont_have_account'),
                        style: context.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: context.tr('sign_up'),
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
    );
  }
}
