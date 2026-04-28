import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/quiz_course/data/model/quiz_model.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class QuizCard extends StatelessWidget {
  final QuizModel quiz;
  const QuizCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final status = quiz.quizStatus;
    final isPassed = status == QuizStatus.passed;
    final isFailed = status == QuizStatus.failed;
    final isCanRetry = status == QuizStatus.canRetry;
    final isMaxAttemptsReached = (quiz.attemptsUsed ?? 0) >= quiz.maxAttempts;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPassed ? Icons.check_circle : Icons.assignment_outlined,
                  color: context.colorScheme.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.quizName,
                      style: context.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${quiz.bestScore ?? 0}/${quiz.totalMark} ${context.tr('marks')}',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('attempts'),
                      style: context.textTheme.labelSmall,
                    ),
                    Text(
                      '${quiz.attemptsUsed ?? 0}/${quiz.maxAttempts}',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              CustomPrimaryButton(
                text: (isPassed || isCanRetry)
                    ? context.tr('retake')
                    : context.tr('start'),
                onTap: (isFailed || (isPassed && isMaxAttemptsReached))
                    ? null
                    : () => context.pushNamed(
                        AppRoutes.quizSession,
                        extra: quiz.slug,
                      ),
                width: 100,
                height: 36,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
