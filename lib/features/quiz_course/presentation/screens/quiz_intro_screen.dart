import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/quiz_course/data/model/quiz_model.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class QuizIntroScreen extends StatelessWidget {
  final QuizModel quiz;
  const QuizIntroScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('exam_details'), style: context.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: 24.h),
            _buildInfoGrid(context),
            SizedBox(height: 32.h),
            Text(
              context.tr('instructions'),
              style: context.textTheme.titleMedium,
            ),
            SizedBox(height: 12.h),
            _buildInstructionItem(context, context.tr('instruction_1')),
            _buildInstructionItem(context, context.tr('instruction_2')),
            _buildInstructionItem(context, context.tr('instruction_3')),
            SizedBox(height: 48.h),
            CustomPrimaryButton(
              text: context.tr('start_exam'),
              onTap: () => context.pushReplacementNamed(AppRoutes.quizSession, extra: quiz.slug),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quiz.quizName,
          style: context.textTheme.displaySmall?.copyWith(color: context.colorScheme.primary),
        ),
        SizedBox(height: 8.h),
        Text(
          quiz.courseName,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.5)),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        children: [
          _buildInfoItem(context, Icons.assignment_outlined, context.tr('total_marks'), quiz.totalMark.toString()),
          _buildInfoItem(context, Icons.refresh, context.tr('max_attempts'), quiz.maxAttempts.toString()),
          _buildInfoItem(context, Icons.history, context.tr('attempts_used'), (quiz.attemptsUsed ?? 0).toString()),
          _buildInfoItem(context, Icons.timer_outlined, context.tr('duration'), '30 ${context.tr('min')}'), // Placeholder
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: context.colorScheme.primary, size: 20.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: context.textTheme.labelSmall),
            Text(value, style: context.textTheme.titleSmall),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructionItem(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
