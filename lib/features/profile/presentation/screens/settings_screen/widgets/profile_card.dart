import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        /// TODO: Navigate to profile screen
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: context.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: context.colorScheme.surfaceVariant,
                  // backgroundImage: NetworkImage('...'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 12.w,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    /// TODO: Get user name from API
                    'Alex Johnson',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Text(
                    /// TODO: Get user email from API
                    'alex.j@skillup.com',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
