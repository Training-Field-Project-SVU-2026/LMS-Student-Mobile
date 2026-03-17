import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomHeadOfPackeDetals extends StatefulWidget {
  const CustomHeadOfPackeDetals({super.key});

  @override
  State<CustomHeadOfPackeDetals> createState() =>
      _CustomHeadOfPackeDetalsState();
}

class _CustomHeadOfPackeDetalsState extends State<CustomHeadOfPackeDetals> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Text(
          "Full Stack Web Development Bundle",
          style: context.textTheme.displayLarge!.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Icon(
              Icons.menu_book_sharp,
              color: context.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            SizedBox(width: 15.w),
            Text(
              "12 Courses included",
              style: context.textTheme.labelLarge!.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
