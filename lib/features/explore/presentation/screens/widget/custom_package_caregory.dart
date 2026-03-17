// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomPackageCaregory extends StatefulWidget {
  final List<String> category;
  const CustomPackageCaregory({super.key, required this.category});

  @override
  State<CustomPackageCaregory> createState() => _CustomPackageCaregoryState();
}

class _CustomPackageCaregoryState extends State<CustomPackageCaregory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.category.length, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              padding: EdgeInsets.all(6.r),
              width: 65.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget.category[index],
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary.withValues(alpha: 0.7),
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      ),
    );
  }
}
