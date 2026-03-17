// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomStreak extends StatelessWidget {
  final String hidtag;
  final String body;
  final Color colorContainer;
  final Color colorIcon;
  final IconData icon;
  final int daysOrHours;

  const CustomStreak({
    super.key,
    required this.hidtag,
    required this.body,
    required this.colorContainer,
    required this.colorIcon,
    required this.icon,
    required this.daysOrHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173.w,
      height: 78.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: colorContainer,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Icon(icon, color: colorIcon, size: 28.sp),
            ),
          ),

          SizedBox(width: 12.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 16.h),
              Text(
                hidtag,
                style: context.textTheme.labelSmall!.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
              // SizedBox(height: 4.h),
              Text(
                "$daysOrHours $body",
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 18.sp,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
