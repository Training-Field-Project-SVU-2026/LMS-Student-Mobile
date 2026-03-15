import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'profile_header.dart';
import 'profile_info_card.dart';

class StudentProfileBody extends StatelessWidget {
  const StudentProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileHeader(),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const ProfileInfoCard(),
                SizedBox(height: 40.h),
                CustomPrimaryButton(
                  text: 'Edit Profile',
                  width: double.infinity,
                  onTap: () {
                    // TODO: Implement edit profile logic
                  },
                ),
                SizedBox(height: 60.h),
                Text(
                  '© 2024 Student Portal v2.1.0',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
