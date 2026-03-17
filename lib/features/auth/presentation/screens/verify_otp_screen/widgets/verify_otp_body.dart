// lib/features/auth/presentation/screens/verify_otp_screen/widgets/verify_otp_body.dart

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../../../../features/widgets/custom_primary_button.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class VerifyOtpBody extends StatelessWidget {
  final String email;
  const VerifyOtpBody({super.key, required this.email});

  @override
  Widget build(BuildContext context) {

    final authBloc = context.read<AuthBloc>();

    return MultiBlocListener(
      listeners: [
      BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthSuccess,
      listener: (context, state) {
        context.go(AppRoutes.loginScreen);
      },
    ),
    
    BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is ResendSuccess,
      listener: (context, state) {
        final resendState = state as ResendSuccess;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(resendState.message),
            backgroundColor: Colors.green,
          ),
        );
      },
    ),
  ],
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => context.go(AppRoutes.loginScreen),
                  icon: CircleAvatar(
                    backgroundColor: context.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18.w,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
      
              SizedBox(height: 20.h),
      
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 40.w,
                  color: context.colorScheme.primary,
                ),
              ),
      
              SizedBox(height: 24.h),
              Text(
                context.tr('verify_otp'),
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                context.tr('we_sent_verification_code'),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
                ),
              ),
      
              SizedBox(height: 40.h),
      
              Form(
                key: authBloc.otpFormKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => _buildOtpBox(context, index, authBloc),
                  ),
                ),
              ),
      
              SizedBox(height: 32.h),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 18.w,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    context.tr('code_expires_in'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      
              SizedBox(height: 16.h),
      
              Center(
                child: TextButton(
                  onPressed: () {
                    authBloc.add(ResendOtpEvent(email: email));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: context.tr('didnt_receive_code'),
                      style: context.textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: context.tr('resend'),
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
      
              SizedBox(height: 40.h),
              Container(
                width: double.infinity,
                height: 160.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.shield_outlined,
                    size: 60.w,
                    color: context.colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
              ),
      
              SizedBox(height: 40.h),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return CustomPrimaryButton(
                    text: isLoading ? context.tr('verifying') : context.tr('verify_otp'),
                    onTap: isLoading
                        ? null
                        : () {
                          // for testing ya قائد don't delete it untill i make sure of the code 
                            log(
                              '🔑 OTP entered: ${authBloc.getOtpCode()}',
                            ); 
                            log('📧 Email: $email');
      
                            // wait here
                            authBloc.add(
                              VerifyEmailEvent(
                                email: email,
                                otp: authBloc.getOtpCode(),
                              ),
                            ); //؟؟
                          },
                    suffixIcon: Icon(
                      Icons.verified,
                      size: 18.w,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, int index, AuthBloc authBloc) {
    return Container(
      width: 45.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Center(
        child: TextFormField(
          controller: authBloc.otpControllers[index],
          onChanged: (value) {
            if (value.length == 1) FocusScope.of(context).nextFocus();
            if (value.isEmpty) FocusScope.of(context).previousFocus();
          },
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.zero,
            isDense: true,
            border: InputBorder.none,
          ),
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
