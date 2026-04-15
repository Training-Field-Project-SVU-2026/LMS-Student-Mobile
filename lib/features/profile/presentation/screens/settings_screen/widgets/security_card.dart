import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, color: context.colorScheme.secondary),
              SizedBox(width: 8.w),
              Text(
                context.tr('security'),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildSecurityItem(
            context,
            title: context.tr('change_password'),
            subtitle: context.tr('update_security_desc'),
            onTap: () => context.pushNamed(AppRoutes.changePasswordScreen),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(subtitle, style: context.textTheme.bodySmall),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.w,
            color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
