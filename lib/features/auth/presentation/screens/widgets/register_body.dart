import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/utils/auth_validation.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.green,
            ),
          );
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: authBloc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30.h),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(alpha: 0.1),
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
                    "Start Your Journey",
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Create an account and commit to growth",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  
                  SizedBox(height: 30.h),
                  
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: authBloc.firstNameController,
                          hintText: 'First Name',
                          prefixIcon: Icon(Icons.person_outline, size: 22.w),
                          validator: (value) => validateFirstName(value),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: CustomTextFormField(
                          controller: authBloc.lastNameController,
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.person_outline, size: 22.w),
                          validator: (value) => validateLastName(value),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: authBloc.emailController,
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined, size: 22.w),
                    validator: (value) => validateEmail(value),
                  ),
                  
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: authBloc.passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                    validator: (value) => validatePassword(value),
                  ),
                  
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: authBloc.confirmPasswordController,
                    hintText: 'Confirm Password',
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != authBloc.passwordController.text) {
                        return 'Passwords do not match';
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
                          text: isLoading ? 'Creating Account...' : 'Create Account',
                          onTap: isLoading ? null : () {
                            FocusScope.of(context).unfocus();
                            context.read<AuthBloc>().add(RegisterEvent());
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
                          width: 250.w,
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 25.h),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: context.colorScheme.outlineVariant),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "OR",
                          style: context.textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                        child: Divider(color: context.colorScheme.outlineVariant),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 25.h),
                  
                  CustomOutlinedButton(
                    text: 'Continue With Google',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Google Sign In coming soon!'),
                        ),
                      );
                    },
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/google.svg"
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
                  
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.go(AppRoutes.loginScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already Have An Account? ",
                          style: context.textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Sign In",
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