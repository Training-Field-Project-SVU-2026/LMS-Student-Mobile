import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/auth/presentation/screens/widgets/auth_toggle_switch.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Registration successful! Please verify your email.',
              ),
              backgroundColor: Colors.green,
            ),
          );

          // context.go(AppRoutes.verifyEmailScreen);
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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30.h),

                  // Logo Section
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
                      color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),

                  SizedBox(height: 30.h),
                  const AuthToggleSwitch(isLogin: false),
                  SizedBox(height: 30.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: firstNameController,
                          hintText: 'First Name',
                          prefixIcon: Icon(Icons.person_outline, size: 22.w),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'First name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: CustomTextFormField(
                          controller: lastNameController,
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.person_outline, size: 22.w),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Last name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined, size: 22.w),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      // TODO: i will do a more efficient validation later
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      // TODO: i will do a more efficient validation later
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, size: 22.w),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
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
                          text: isLoading
                              ? 'Creating Account...'
                              : 'Create Account',
                          onTap: isLoading
                              ? null
                              : () {
                                  // الفورم كي دا بيتاكد ان كل الفيلدس صح ومش فاضية ولو تمما هيعمل ريجستر ريكويست
                                  if (formKey.currentState!.validate()) {
                                    final request = RegisterRequestModel(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    context.read<AuthBloc>().add(
                                      RegisterEvent(request: request),
                                    );
                                  }
                                },
                          suffixIcon: Icon(
                            Icons.arrow_forward,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                            size: 20.w,
                          ),
                          width: 287.w,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 30.h),

                  //
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w),
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
                          child: Text("OR", style: context.textTheme.labelMedium?.copyWith(
                            color: context.colorScheme.primary,
                          )),
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
                        side: BorderSide(
                          color: context.colorScheme.outline,
                        ),
                      ),
                      width: 287.w,
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

                  SizedBox(height: 20.h),

                  // Sign In
                  Center(
                    child: TextButton(
                      onPressed: () {
                        //context.go(AppRoutes.otpScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already Have An Account? ",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.outlineVariant.withValues(alpha: 0.5),
                          ),
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
