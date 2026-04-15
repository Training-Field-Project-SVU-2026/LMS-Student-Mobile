import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/utils/get_responsive_size.dart';

class VerifyOtpBody extends StatefulWidget {
  final String email;
  const VerifyOtpBody({super.key, required this.email});

  @override
  State<VerifyOtpBody> createState() => _VerifyOtpBodyState();
}

class _VerifyOtpBodyState extends State<VerifyOtpBody> {
  Timer? _timer;
  int _remainingSeconds = 120;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                backgroundColor: context.colorScheme.secondary,
              ),
            );
            // Reset timer when resend is successful
            setState(() {
              _remainingSeconds = 120;
            });
            _startTimer();
          },
        ),
      ],
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? 80 : 36.w,
            vertical: context.isDesktop ? 80 : 56.h,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.tr('verify_otp'),
                  style: context.textTheme.displaySmall!.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  context.tr('we_sent_verification_code'),
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 48.h),

                Text(
                  context.tr('verification_code'),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),

                Form(
                  key: authBloc.otpFormKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      size: context.isDesktop ? 22 : 18.w,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${context.tr('code_expires_in').replaceFirst(' 01:00', '')}: ${_formatTime(_remainingSeconds)}',
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
                    onPressed: _remainingSeconds == 0
                        ? () {
                            authBloc.add(ResendOtpEvent(email: widget.email));
                          }
                        : null,
                    child: RichText(
                      text: TextSpan(
                        text: context.tr('didnt_receive_code'),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: _remainingSeconds == 0
                              ? null
                              : context.colorScheme.onSurfaceVariant.withValues(
                                  alpha: 0.5,
                                ),
                        ),
                        children: [
                          TextSpan(
                            text: ' ${context.tr('resend')}',
                            style: TextStyle(
                              color: _remainingSeconds == 0
                                  ? context.colorScheme.primary
                                  : context.colorScheme.primary.withValues(
                                      alpha: 0.5,
                                    ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return CustomPrimaryButton(
                      text: isLoading
                          ? context.tr('verifying')
                          : context.tr('verify_otp'),
                      onTap: isLoading
                          ? null
                          : () {
                              authBloc.add(
                                VerifyEmailEvent(
                                  email: widget.email,
                                  otp: authBloc.getOtpCode(),
                                ),
                              );
                            },
                      width: double.infinity,
                    );
                  },
                ),

                SizedBox(height: 24.h),

                Center(
                  child: TextButton.icon(
                    onPressed: () => context.go(AppRoutes.loginScreen),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: context.isDesktop ? 22 : 14.w,
                    ),
                    label: Text(context.tr('back_to_login')),
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.onSecondary
                          .withValues(alpha: 0.5),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: context.isDesktop ? 14 : 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, int index, AuthBloc authBloc) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.isDesktop ? 8 : 4.w),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.primary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              controller: authBloc.otpControllers[index],
              onChanged: (value) {
                if (value.length == 1 && index < 5) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: context.colorScheme.secondary.withValues(
                  alpha: 0.03,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: context.colorScheme.secondary.withValues(
                      alpha: 0.15,
                    ),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: context.colorScheme.secondary,
                    width: 2.5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
