import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final Widget? icon;
  final String primaryButtonText;
  final VoidCallback primaryButtonOnTap;
  final String? secondaryButtonText;
  final VoidCallback? secondaryButtonOnTap;

  const CustomDialog({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    required this.primaryButtonText,
    required this.primaryButtonOnTap,
    this.secondaryButtonText,
    this.secondaryButtonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            SizedBox(height: 16.h),
          ],
          Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPrimaryButton(
                text: primaryButtonText,
                width: double.infinity,
                onTap: primaryButtonOnTap,
              ),
              if (secondaryButtonText != null) ...[
                SizedBox(height: 12.h),
                CustomOutlinedButton(
                  text: secondaryButtonText!,
                  width: double.infinity,
                  onTap: secondaryButtonOnTap,
                ),
              ],
            ],
          ),
        ),
      ],
      actionsPadding: EdgeInsets.fromLTRB(16.r, 0, 16.r, 24.r),
      contentPadding: EdgeInsets.fromLTRB(24.r, 16.r, 24.r, 24.r),
    );
  }
}
