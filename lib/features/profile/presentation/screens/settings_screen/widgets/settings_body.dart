import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/profile_card.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/app_preferences_card.dart';
import 'package:lms_student/features/profile/presentation/screens/settings_screen/widgets/delete_account_card.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.go(AppRoutes.loginScreen);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: context.textTheme.displayLarge?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Manage your account and learning experience',
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(height: 24.h),

              const ProfileCard(),
              SizedBox(height: 24.h),

              const AppPreferencesCard(),
              SizedBox(height: 24.h),

              const DeleteAccountCard(),
              SizedBox(height: 24.h),

              CustomOutlinedButton(
                text: 'Change Password',
                width: double.infinity,
                onTap: () {
                  context.pushNamed(AppRoutes.changePasswordScreen);
                },
                textStyle: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colorScheme.outline),
                ),
              ),
              SizedBox(height: 24.h),

              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  final isLoading = state is LogoutLoading;

                  return Center(
                    child: TextButton.icon(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<ProfileBloc>().add(LogoutEvent());
                            },
                      icon: isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: context.colorScheme.error,
                              ),
                            )
                          : Icon(
                              Icons.logout,
                              color: context.colorScheme.error,
                            ),
                      label: Text(
                        isLoading ? 'Signing Out...' : 'Sign Out',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
