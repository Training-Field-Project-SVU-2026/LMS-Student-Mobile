import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/widgets/edit_profile_dialog.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/widgets/profile_info_item.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

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
                SizedBox(height: 32.h),
                Container(
                  width: 120.r,
                  height: 120.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colorScheme.secondary),
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
                  child: CircleAvatar(
                    backgroundColor: context.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
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
                SizedBox(height: 24.h),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    context.tr('student'),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      // fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                ProfileInfoItem(
                  label: context.tr('first_name'),
                  value: user.firstName,
                ),
                SizedBox(height: 12.h),
                ProfileInfoItem(
                  label: context.tr('last_name'),
                  value: user.lastName,
                ),
                SizedBox(height: 12.h),
                ProfileInfoItem(
                  label: context.tr('email_address'),
                  value: user.email,
                  hasDivider: false,
                ),

                SizedBox(height: 32.h),

                SizedBox(height: 120.h),

                CustomPrimaryButton(
                  text: context.tr('edit_profile'),
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
                SizedBox(height: 50.h),
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
