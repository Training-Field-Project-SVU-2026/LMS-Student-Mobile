import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../../../features/auth/utils/auth_validation.dart';
import '../../../../../../features/widgets/custom_primary_button.dart';
import '../../../../../../features/widgets/custom_text_form_field.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    // سحبنا الـ Bloc اللي اتعرف في الـ Screen فوق
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgetPasswordEmailSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reset link sent to your email!'),
              backgroundColor: Colors.green,
            ),
          );
          // ممكن هنا ترجعيه لصفحة اللوجن بعد نجاح الإرسال
          // context.go(AppRoutes.loginScreen);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Column(
        children: [
          // الجزء العلوي (Header) بنفس ستايل "Commit Ma3ana"
          Container(
            width: double.infinity,
            height: 280.h,
            color: context.colorScheme.primary,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.code, color: Colors.white, size: 28.w),
                      SizedBox(width: 8.w),
                      Text(
                        "Commit Ma3ana",
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  // حاوية الصورة (Illustration)
                  Container(
                    width: 200.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        'assets/images/forget_password_ill.png', // حطي صورتك هنا
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.lock_reset,
                          color: Colors.white54,
                          size: 60.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // الجزء السفلي (Form)
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: authBloc
                      .forgetPasswordFormKey, // Key لازم يتعرف في الـ Bloc
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        "Forget Password?",
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Enter your email address below and we'll send you a link to reset your password.",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // حقل الإدخال مربوط بالـ Controller والـ Validator
                      CustomTextFormField(
                        controller: authBloc.emailController,
                        hintText: 'name@example.com',
                        prefixIcon: Icon(Icons.email_outlined, size: 22.w),
                        validator: (value) => validateEmail(value),
                      ),

                      SizedBox(height: 32.h),

                      // الزرار مربوط بالـ BlocBuilder عشان الـ Loading
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;

                          return Align(
                            alignment: Alignment.center,
                            child: CustomPrimaryButton(
                              text: isLoading
                                  ? 'Sending...'
                                  : 'Send Reset Link',
                              width: 287.w,
                              onTap: isLoading
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      authBloc.add(ForgetPasswordEvent());
                                    },
                              suffixIcon: isLoading
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.w,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 18.w,
                                    ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 25.h),

                      // الرجوع للـ Login
                      TextButton(
                        onPressed: () => context.go(AppRoutes.loginScreen),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 18.w,
                              color: context.colorScheme.primary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Back to Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.h),
                      Text(
                        "Join thousands of learners building consistency and growing their programming skills — one commit at a time.",
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.outline,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
