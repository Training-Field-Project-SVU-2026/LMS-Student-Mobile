import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/quiz_course/data/model/quiz_model.dart';

class PerformanceSummaryCard extends StatelessWidget {
  final List<QuizModel> quizzes;
  const PerformanceSummaryCard({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    int totalPossible = 0;
    int totalAchieved = 0;
    int quizzesTaken = 0;

    for (final quiz in quizzes) {
      if ((quiz.attemptsUsed ?? 0) > 0 || quiz.isPassed || quiz.isFailed) {
        quizzesTaken++;
        totalPossible += quiz.totalMark;
        totalAchieved += (quiz.bestScore ?? 0);
      }
    }

    final bestScorePercentage = totalPossible > 0 
        ? ((totalAchieved / totalPossible) * 100).round()
        : 0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildScoreItem(context, context.tr('best_score'), '$bestScorePercentage%'),
              Container(width: 1.w, height: 40.h, color: context.colorScheme.onPrimary.withOpacity(0.3)),
              _buildScoreItem(context, context.tr('completed'), '$quizzesTaken / ${quizzes.length}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreItem(BuildContext context, String label, String score) {
    return Column(
      children: [
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onPrimary.withOpacity(0.7),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          score,
          style: context.textTheme.headlineLarge?.copyWith(
            color: context.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
