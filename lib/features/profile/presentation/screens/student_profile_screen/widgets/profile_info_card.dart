import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          _buildInfoRow(context, 'FIRST NAME', 'Alex'),
          Divider(height: 1, color: context.colorScheme.outline.withValues(alpha: 0.2)),
          _buildInfoRow(context, 'LAST NAME', 'Johnson'),
          Divider(height: 1, color: context.colorScheme.outline.withValues(alpha: 0.2)),
          _buildInfoRow(context, 'EMAIL ADDRESS', 'alex.johnson@university.edu', isFullWidth: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, {bool isFullWidth = false}) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
              if (!isFullWidth)
                Text(
                  value,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
            ],
          ),
          if (isFullWidth) ...[
            SizedBox(height: 8.h),
            Text(
              value,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
