import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/quiz_course/presentation/bloc/quiz_course_bloc.dart';
import 'package:lms_student/features/widgets/loading_indicator_widget.dart';
import 'package:lms_student/features/widgets/error_feedback_widget.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'widgets/choice_item.dart';

class QuizSessionScreen extends StatefulWidget {
  final String quizSlug;
  const QuizSessionScreen({super.key, required this.quizSlug});

  @override
  State<QuizSessionScreen> createState() => _QuizSessionScreenState();
}

class _QuizSessionScreenState extends State<QuizSessionScreen> {
  int _currentIndex = 0;
  final Map<String, List<String>> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submitQuiz() {
    final answersList = _selectedAnswers.entries
        .map((e) => {'question_slug': e.key, 'choice_slugs': e.value})
        .toList();
    context.read<QuizCourseBloc>().add(
      SubmitQuizEvent(widget.quizSlug, answersList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCourseBloc, QuizCourseState>(
      listener: (context, state) {
        if (state is SubmitQuizSuccess) {
          context.pushReplacementNamed(
            AppRoutes.quizResult,
            extra: state.result,
          );
        } else if (state is SubmitQuizError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.tr('quiz'),
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: _submitQuiz,
              child: Text(
                context.tr('finish'),
                style: TextStyle(color: context.colorScheme.error),
              ),
            ),
          ],
        ),
        body: BlocBuilder<QuizCourseBloc, QuizCourseState>(
          buildWhen: (previous, current) =>
              current is GetQuestionsLoading ||
              current is GetQuestionsSuccess ||
              current is GetQuestionsError,
          builder: (context, state) {
            if (state is GetQuestionsLoading) {
              return const LoadingIndicatorWidget();
            } else if (state is GetQuestionsError) {
              return ErrorFeedbackWidget(
                errorMessage: state.message,
                onRetry: () => context.read<QuizCourseBloc>().add(
                  GetQuizQuestionsEvent(widget.quizSlug),
                ),
              );
            } else if (state is GetQuestionsSuccess) {
              final questions = state.uiModel?.questions ?? [];
              if (questions.isEmpty) {
                return const Center(child: Text('No questions found'));
              }

              final isCurrentIndexValid = _currentIndex < questions.length;
              final totalQuestions =
                  state.uiModel?.totalQuestions ?? questions.length;
              final progress = (_currentIndex + 1) / totalQuestions;

              if (!isCurrentIndexValid) {
                return const LoadingIndicatorWidget();
              }

              final currentQuestion = questions[_currentIndex];

              return Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: context.colorScheme.outline.withOpacity(
                      0.2,
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${context.tr('question')} ${_currentIndex + 1} ${context.tr('of')} $totalQuestions',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            currentQuestion.questionName,
                            style: context.textTheme.headlineSmall,
                          ),
                          SizedBox(height: 24.h),
                          ...currentQuestion.choices.map((choice) {
                            final isSelected =
                                _selectedAnswers[currentQuestion.slug]
                                    ?.contains(choice.slug) ??
                                false;
                            return ChoiceItem(
                              choice: choice,
                              isSelected: isSelected,
                              isMultiple:
                                  currentQuestion.questionType == 'multiple',
                              onTap: () {
                                setState(() {
                                  if (currentQuestion.questionType ==
                                      'single') {
                                    _selectedAnswers[currentQuestion.slug] = [
                                      choice.slug,
                                    ];
                                  } else {
                                    final currentSelected =
                                        _selectedAnswers[currentQuestion
                                            .slug] ??
                                        [];
                                    if (isSelected) {
                                      currentSelected.remove(choice.slug);
                                    } else {
                                      currentSelected.add(choice.slug);
                                    }
                                    _selectedAnswers[currentQuestion.slug] =
                                        currentSelected;
                                  }
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  _buildFooter(context, questions.length, state),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    int totalInCurrentList,
    GetQuestionsSuccess state,
  ) {
    final uiModel = state.uiModel;
    final hasNextPage =
        uiModel != null && uiModel.currentPage < uiModel.totalPages;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentIndex > 0)
            OutlinedButton(
              onPressed: () => setState(() => _currentIndex--),
              child: Text(context.tr('previous')),
            )
          else
            const SizedBox.shrink(),
          CustomPrimaryButton(
            text: (_currentIndex == totalInCurrentList - 1 && !hasNextPage)
                ? context.tr('submit')
                : context.tr('next'),
            onTap: () {
              if (_currentIndex < totalInCurrentList - 1) {
                setState(() => _currentIndex++);
              } else if (hasNextPage) {
                if (!state.isPaginationLoading) {
                  context.read<QuizCourseBloc>().add(
                    GetQuizQuestionsEvent(
                      widget.quizSlug,
                      page: uiModel.currentPage + 1,
                    ),
                  );
                  setState(() => _currentIndex++);
                }
              } else {
                _submitQuiz();
              }
            },
            width: 120,
            height: 44,
          ),
        ],
      ),
    );
  }
}
