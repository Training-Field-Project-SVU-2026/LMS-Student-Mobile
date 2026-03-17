import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool hasDivider;

  const ProfileInfoItem({
    super.key,
    required this.label,
    required this.value,
    this.hasDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.6,
                  ),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasDivider)
          Divider(
            height: 1,
            indent: 16.w,
            endIndent: 16.w,
            color: context.colorScheme.outline.withValues(alpha: 0.2),
          ),
      ],
    );
  }
}
