import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/explore/widget/feature_model.dart';

class FeatureButton extends StatelessWidget {
  final FeatureModel model;

  const FeatureButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: model.color,
            borderRadius: BorderRadius.circular(35.r),
          ),
          child: Icon(
            model.icon,
            size: 30.sp,
            color: context.colorScheme.primary,
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          model.text,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
