import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/quiz_course/data/model/attempt_result_model.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'widgets/answer_review_list.dart';
import 'widgets/quiz_result_header.dart';
import 'widgets/score_progress_ring.dart';
import 'widgets/quiz_stats_grid.dart';

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
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizResultHeader(
                isPassed: isPassed,
                isMaxAttemptsReached: isMaxAttemptsReached,
              ),
              SizedBox(height: 48.h),
              ScoreProgressRing(
                percentage: percentage,
                score: result.score,
                totalMark: result.totalMark,
              ),
              SizedBox(height: 48.h),
              QuizStatsGrid(
                totalMark: result.totalMark,
                score: result.score,
                passingPercentage: result.passingPercentage,
              ),
              SizedBox(height: 40.h),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: CustomPrimaryButton(
                    text: context.tr('back_to_course'),
                    onTap: () => context.pop(),
                    width: double.infinity,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              if (result.answers != null && result.answers!.isNotEmpty) ...[
                SizedBox(height: 16.h),
                AnswerReviewList(answers: result.answers!),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
