import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colorScheme.surface,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 55.r,
            backgroundColor: context.colorScheme.surfaceVariant,
            child: Icon(
              Icons.person,
              size: 60.r,
              color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Alex Johnson',
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Student ID: #2024-8892',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
