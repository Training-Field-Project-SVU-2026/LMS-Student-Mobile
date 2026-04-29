import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class QuizResultHeader extends StatelessWidget {
  final bool isPassed;
  final bool isMaxAttemptsReached;

  const QuizResultHeader({
    super.key,
    required this.isPassed,
    required this.isMaxAttemptsReached,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 24.h),
        Text(
          isPassed
              ? context.tr('congratulations')
              : (isMaxAttemptsReached
                    ? context.tr('better_luck_next_time')
                    : context.tr('try_again')),
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          isPassed
              ? context.tr('exam_completed_desc')
              : (isMaxAttemptsReached
                    ? context.tr('max_attempts_reached_desc')
                    : context.tr('exam_failed_desc')),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
