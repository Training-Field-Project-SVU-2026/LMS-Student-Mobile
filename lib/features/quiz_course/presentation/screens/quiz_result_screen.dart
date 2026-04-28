import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/quiz_course/data/model/attempt_result_model.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class QuizResultScreen extends StatelessWidget {
  final AttemptResultModel result;
  const QuizResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final isPassed =
        result.status.toLowerCase() == 'passed' || (result.passed ?? false);
    final percentage = result.percentage ??
        ((result.score / result.totalMark) * 100).toInt();
    final isMaxAttemptsReached = result.maxAttempts != null &&
        result.attemptNumber >= result.maxAttempts!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              _buildIllustration(context, isPassed, isMaxAttemptsReached),
              SizedBox(height: 32.h),
              _buildScoreCard(context, percentage),
              SizedBox(height: 24.h),
              _buildStatsRow(context),
              SizedBox(height: 48.h),
              CustomPrimaryButton(
                text: context.tr('back_to_course'),
                onTap: () => context.pop(),
                width: double.infinity,
                color: isPassed ? Colors.green : context.colorScheme.primary,
              ),
              if (result.answers != null && result.answers!.isNotEmpty) ...[
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.tr('review_answers'),
                    style: context.textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 16.h),
                ...result.answers!
                    .map((answer) => _buildAnswerItem(context, answer)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration(
      BuildContext context, bool isPassed, bool isMaxAttemptsReached) {
    return Column(
      children: [
        Icon(
          isPassed
              ? Icons.emoji_events_outlined
              : Icons.sentiment_very_dissatisfied_outlined,
          size: 100.sp,
          color: isPassed ? Colors.amber : context.colorScheme.error,
        ),
        SizedBox(height: 16.h),
        Text(
          isPassed
              ? context.tr('congratulations')
              : (isMaxAttemptsReached
                  ? context.tr('better_luck_next_time')
                  : context.tr('try_again')),
          style: context.textTheme.displaySmall?.copyWith(
            color: isPassed ? Colors.green : context.colorScheme.error,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          isPassed
              ? context.tr('exam_completed_desc')
              : (isMaxAttemptsReached
                  ? context.tr('max_attempts_reached_desc')
                  : context.tr('exam_failed_desc')),
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildScoreCard(BuildContext context, int percentage) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Text(
            context.tr('final_score'),
            style: context.textTheme.labelMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            '$percentage%',
            style: context.textTheme.displayLarge?.copyWith(
              color: context.colorScheme.primary,
              fontSize: 48.sp,
            ),
          ),
          Text(
            '${result.score} / ${result.totalMark}',
            style: context.textTheme.titleMedium
                ?.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(context, context.tr('total'), result.totalMark.toString(),
            Icons.quiz_outlined, Colors.blue),
        _buildStatItem(context, context.tr('correct'), result.score.toString(),
            Icons.check_circle_outline, Colors.green),
        _buildStatItem(
            context,
            context.tr('incorrect'),
            (result.totalMark - result.score).toString(),
            Icons.cancel_outlined,
            Colors.red),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value,
      IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(value,
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: context.textTheme.labelSmall),
      ],
    );
  }

  Widget _buildAnswerItem(BuildContext context, SelectedAnswerModel answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: answer.isCorrect
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                answer.isCorrect ? Icons.check_circle : Icons.cancel,
                color: answer.isCorrect ? Colors.green : Colors.red,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  answer.question,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              style: context.textTheme.bodySmall,
              children: [
                TextSpan(
                  text: '${context.tr("your_answer")}: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: answer.selectedChoices.join(", ")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
