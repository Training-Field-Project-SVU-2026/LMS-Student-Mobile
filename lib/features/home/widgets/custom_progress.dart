import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class CustomProgress extends StatefulWidget {
  const CustomProgress({super.key});

  @override
  State<CustomProgress> createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Continue Learning',
              style: context.textTheme.labelLarge!.copyWith(
                fontSize: 10.sp,
                color: context.colorScheme.surface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Complete Web Development Bootcamp',
              style: context.textTheme.labelLarge!.copyWith(
                fontSize: 20.sp,
                color: context.colorScheme.surface,
              ),
            ),

            SizedBox(height: 22.h),
            Row(
              children: [
                Text(
                  "Progress",
                  style: context.textTheme.labelMedium!.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.surface,
                  ),
                ),
                const Spacer(),
                Text(
                  "75%",
                  style: context.textTheme.labelMedium!.copyWith(
                    fontSize: 14.sp,
                    color: context.colorScheme.surface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                // value: progress, Todo: calculate progress based on completedVideos and totalVideos
                value: 0.7,
                borderRadius: BorderRadius.circular(4.r),
                backgroundColor: context.colorScheme.surface.withValues(
                  alpha: 0.3,
                ),
                valueColor: AlwaysStoppedAnimation<Color>(
                  context.colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(height: 22.h),
            Center(
              child: CustomPrimaryButton(
                onTap: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                text: "Resume Learning",
                textStyle: context.textTheme.labelMedium!.copyWith(
                  fontSize: 14.sp,
                  color: context.colorScheme.primary,
                ),
                prefixIcon: Icon(Icons.play_arrow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
