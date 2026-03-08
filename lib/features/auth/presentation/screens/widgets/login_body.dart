import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_toggle_switch.dart';
import 'package:lms_student/features/auth/utils/auth_validation.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRoutes.homeScreen);

        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
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
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.code,
                          color: context.colorScheme.primary,
                          size: 35.w,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Eight Names App 😎",
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),
                Text(
                  "Welcome Back!",
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Sign in to continue your learning path",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant
                  ),
                ),

                SizedBox(height: 24.h),

                AuthToggleSwitch(isLogin: true),

                SizedBox(height: 25.h,),
                CustomTextFormField(
                  controller: authBloc.emailController,
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined, size: 22.w),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validateEmail(value),
                ),
                
                SizedBox(height: 16.h),
                
                CustomTextFormField(
                  controller: authBloc.passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                  validator: (value) => validatePassword(value),
                  keyboardType: TextInputType.visiblePassword,
                ),
                
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                       // go to forget password screen
                    },
                    child: Text(
                      "Forgot Password?",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.primary
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
                
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    
                    return CustomPrimaryButton(
                      text: isLoading ? 'Signing In...' : 'Sign In',
                      onTap: isLoading ? null : () {
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
                              color: Colors.white,
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
                            color: context.colorScheme.outlineVariant
                                .withValues(alpha: 0.15),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "OR",
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
                      width: 400.w,
                      text: 'Continue With Google',
                      onTap: () {
                        // Google Sign In
                      },
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/google.svg",
                        width: 20,
                      ),
                    ),
                  ),
                
                SizedBox(height: 50.h,),
                
                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.go(AppRoutes.registerScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't Have An Account? ",
                        style: context.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Sign Up",
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