// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomCourseMaterial extends StatefulWidget {
  final String text;
  final IconData icon;
  final void Function() onTap;
  final double? width;
  const CustomCourseMaterial({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.width,
  });

  @override
  State<CustomCourseMaterial> createState() => _CustomCourseMaterialState();
}

class _CustomCourseMaterialState extends State<CustomCourseMaterial> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: context.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: context.colorScheme.primary.withValues(alpha: 0.2),
            width: 1.w,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: context.colorScheme.primary,
                size: 24.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                widget.text,
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
