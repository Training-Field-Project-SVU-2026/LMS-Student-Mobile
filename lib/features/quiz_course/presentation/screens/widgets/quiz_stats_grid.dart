import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class QuizStatsGrid extends StatelessWidget {
  final int totalMark;
  final int score;
  final int? passingPercentage;

  const QuizStatsGrid({
    super.key,
    required this.totalMark,
    required this.score,
    this.passingPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: context.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (passingPercentage != null) ...[
            _buildStatBlock(
              context,
              context.tr('passing'),
              '$passingPercentage%',
              context.colorScheme.primary,
            ),
            Container(
              width: 1.w,
              height: 40.h,
              color: context.colorScheme.outlineVariant.withOpacity(0.5),
            ),
          ],
          _buildStatBlock(
            context,
            context.tr('total_marks'),
            totalMark.toString(),
            context.colorScheme.primary,
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: context.colorScheme.outlineVariant.withOpacity(0.5),
          ),
          _buildStatBlock(
            context,
            context.tr('correct'),
            score.toString(),
            Colors.green,
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: context.colorScheme.outlineVariant.withOpacity(0.5),
          ),
          _buildStatBlock(
            context,
            context.tr('incorrect'),
            (totalMark - score).toString(),
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStatBlock(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
