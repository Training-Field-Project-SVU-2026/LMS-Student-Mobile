import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/quiz_course/presentation/bloc/quiz_course_bloc.dart';
import 'package:lms_student/features/widgets/loading_indicator_widget.dart';
import 'package:lms_student/features/widgets/error_feedback_widget.dart';
import 'package:go_router/go_router.dart';
import 'widgets/performance_summary_card.dart';
import 'widgets/quiz_card.dart';

class QuizListScreen extends StatefulWidget {
  final String courseSlug;
  const QuizListScreen({super.key, required this.courseSlug});

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels >= notification.metrics.maxScrollExtent * 0.8) {
      final state = context.read<QuizCourseBloc>().state;
      if (state is GetQuizzesSuccess) {
        final uiModel = state.uiModel;
        if (uiModel != null && uiModel.currentPage < uiModel.totalPages && !state.isPaginationLoading) {
          context.read<QuizCourseBloc>().add(GetQuizzesByCourseEvent(widget.courseSlug, page: uiModel.currentPage + 1));
        }
      }
    }
    return false;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('exams'), style: context.textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<QuizCourseBloc, QuizCourseState>(
        buildWhen: (previous, current) =>
            current is GetQuizzesLoading || current is GetQuizzesSuccess || current is GetQuizzesError,
        builder: (context, state) {
          if (state is GetQuizzesLoading) {
            return const LoadingIndicatorWidget();
          } else if (state is GetQuizzesError) {
            return ErrorFeedbackWidget(
              errorMessage: state.message,
              onRetry: () => context.read<QuizCourseBloc>().add(GetQuizzesByCourseEvent(widget.courseSlug)),
            );
          } else if (state is GetQuizzesSuccess) {
            final quizzes = state.uiModel?.quizzes ?? [];
            if (quizzes.isEmpty) {
              return Center(child: Text(context.tr('view_course_nothing_added')));
            }

            return Column(
              children: [
                PerformanceSummaryCard(quizzes: quizzes),
                SizedBox(height: 20.h),
                _buildTabBar(context),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildQuizList(quizzes, state.isPaginationLoading),
                      _buildQuizList(state.uiModel!.completedQuizzes, false),
                      _buildQuizList(state.uiModel!.pendingQuizzes, false),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: context.colorScheme.onPrimary,
        unselectedLabelColor: context.colorScheme.onSurfaceVariant,
        labelStyle: context.textTheme.titleSmall,
        tabs: [
          Tab(text: context.tr('all_exams')),
          Tab(text: context.tr('completed')),
          Tab(text: context.tr('pending')),
        ],
      ),
    );
  }

  Widget _buildQuizList(List quizzes, bool isPaginating) {
    if (quizzes.isEmpty) {
      return Center(child: Text(context.tr('view_course_notFound')));
    }
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: quizzes.length + (isPaginating ? 1 : 0),
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
        if (index < quizzes.length) {
          return QuizCard(quiz: quizzes[index]);
        } else {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
      ),
    );
  }
}
