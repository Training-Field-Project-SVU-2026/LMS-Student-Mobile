// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomCourseMaterial extends StatefulWidget {
  final String text;
  final IconData icon;
  final void Function() onTap;
  const CustomCourseMaterial({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  State<CustomCourseMaterial> createState() => _CustomCourseMaterialState();
}

class _CustomCourseMaterialState extends State<CustomCourseMaterial> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 130.w,
        height: 65.h,
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: context.colorScheme.surface),
              Text(
                widget.text,
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
