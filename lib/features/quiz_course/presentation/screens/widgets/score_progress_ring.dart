import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class ScoreProgressRing extends StatelessWidget {
  final int percentage;
  final int score;
  final int totalMark;

  const ScoreProgressRing({
    super.key,
    required this.percentage,
    required this.score,
    required this.totalMark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 200.w,
            height: 200.w,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: percentage / 100),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return CircularProgressIndicator(
                  value: value,
                  strokeWidth: 12.w,
                  backgroundColor: context.colorScheme.primary.withOpacity(0.1),
                  color: context.colorScheme.primary,
                  strokeCap: StrokeCap.round,
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr('final_score'),
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '$percentage%',
                style: context.textTheme.displayMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '$score / $totalMark ${context.tr('marks')}',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
