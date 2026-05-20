import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/widgets/edit_profile_dialog.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/widgets/profile_info_item.dart';
import 'package:lms_student/features/widgets/loading_indicator_widget.dart';
import 'package:lms_student/features/widgets/error_feedback_widget.dart';

class StudentProfileBody extends StatelessWidget {
  const StudentProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          final user = state.user;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.05,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.04,
                        ),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('profile'),
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(
                            height: 36.h,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) =>
                                      BlocProvider.value(
                                        value: context.read<ProfileBloc>(),
                                        child: EditProfileDialog(
                                          initialFirstName: user.firstName,
                                          initialLastName: user.lastName,
                                          initialEmail: user.email,
                                        ),
                                      ),
                                );
                              },
                              icon: Icon(Icons.edit, size: 16.sp),
                              label: Text(
                                context.tr('edit'),
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: context.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colorScheme.primary,
                                foregroundColor: context.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      Container(
                        width: 110.r,
                        height: 110.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.colorScheme.outline.withValues(
                              alpha: 0.5,
                            ),
                            width: 4,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: context.colorScheme.primary
                              .withValues(alpha: 0.1),
                          child: Text(
                            '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}'
                                .toUpperCase(),
                            style: context.textTheme.displayMedium?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        context.tr('student'),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      ProfileInfoItem(
                        icon: Icons.person_outline_rounded,
                        label: context.tr('first_name'),
                        value: user.firstName,
                        iconColor: context.colorScheme.primary,
                      ),

                      SizedBox(height: 16.h),

                      ProfileInfoItem(
                        icon: Icons.person_outline_rounded,
                        label: context.tr('last_name'),
                        value: user.lastName,
                        iconColor: context.colorScheme.primary,
                      ),

                      SizedBox(height: 16.h),

                      ProfileInfoItem(
                        icon: Icons.email_outlined,
                        label: context.tr('email_address'),
                        value: user.email,
                        iconColor: context.colorScheme.primary,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          );
        } else if (state is ProfileLoading) {
          return const LoadingIndicatorWidget();
        } else if (state is ProfileError) {
          return ErrorFeedbackWidget(
            errorMessage: state.message,
            onRetry: () {
              context.read<ProfileBloc>().add(GetProfileEvent());
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
