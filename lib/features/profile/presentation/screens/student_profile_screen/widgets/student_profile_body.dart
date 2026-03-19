import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/widgets/edit_profile_dialog.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/widgets/profile_info_item.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class StudentProfileBody extends StatelessWidget {
  const StudentProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          final user = state.user;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 32.h),
                Center(
                  child: Container(
                    color: context.colorScheme.surface,
                    padding: EdgeInsets.all(24.w),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: 120.r,
                          height: 120.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          child: Center(
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
                          style: context.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Student ID: ${user.slug}',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: context.colorScheme.outline.withValues(alpha: 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.02,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ProfileInfoItem(
                        label: 'First Name',
                        value: user.firstName,
                      ),
                      ProfileInfoItem(label: 'Last Name', value: user.lastName),
                      ProfileInfoItem(
                        label: 'Email Address',
                        value: user.email,
                        hasDivider: false,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomPrimaryButton(
                    text: 'Edit Profile',
                    width: double.infinity,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<ProfileBloc>(),
                          child: EditProfileDialog(
                            initialFirstName: user.firstName,
                            initialLastName: user.lastName,
                            initialEmail: user.email,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 100.h),

                Text(
                  '© 2024 Student Portal v2.1.0',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          );
        } else if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
