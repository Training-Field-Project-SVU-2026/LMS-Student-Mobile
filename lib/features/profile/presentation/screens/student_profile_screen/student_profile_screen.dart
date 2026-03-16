import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/profile/presentation/screens/student_profile_screen/widgets/student_profile_body.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 120.w,
        leading: TextButton.icon(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16.sp,
            color: context.colorScheme.primary,
          ),
          label: Text(
            'Settings',
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.visible,
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        title: Text(
          'Profile',
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(
            height: 1.h,
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      body: const StudentProfileBody(),
    );
  }
}
