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
import 'package:lms_student/features/quiz_course/presentation/bloc/cubit/quiz_answers_cubit.dart';
import 'package:lms_student/features/quiz_course/presentation/bloc/cubit/quiz_session_index_cubit.dart';
import 'widgets/choice_item.dart';
import 'package:lms_student/features/widgets/custom_confirmation_dialog.dart';

class QuizSessionScreen extends StatefulWidget {
  final String quizSlug;
  const QuizSessionScreen({super.key, required this.quizSlug});

  @override
  State<QuizSessionScreen> createState() => _QuizSessionScreenState();
}

class _QuizSessionScreenState extends State<QuizSessionScreen> {
  late final QuizAnswersCubit _answersCubit;
  late final QuizSessionIndexCubit _indexCubit;
  bool _canPop = false;

  @override
  void initState() {
    super.initState();
    _answersCubit = QuizAnswersCubit();
    _indexCubit = QuizSessionIndexCubit();
  }

  @override
  void dispose() {
    _answersCubit.close();
    _indexCubit.close();
    super.dispose();
  }

  void _submitQuiz() {
    final answersList = _answersCubit.state.entries
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
      child: PopScope(
        canPop: _canPop,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          final shouldPop =
              await showDialog<bool>(
                context: context,
                builder: (context) => CustomConfirmationDialog(
                  title: context.tr('quit_quiz') == 'quit_quiz'
                      ? 'Quit Quiz?'
                      : context.tr('quit_quiz'),
                  description: context.tr('quit_quiz_desc') == 'quit_quiz_desc'
                      ? 'Are you sure you want to exit? Your progress will be lost and this attempt will not be saved.'
                      : context.tr('quit_quiz_desc'),
                  confirmText: context.tr('quit') == 'quit'
                      ? 'Quit'
                      : context.tr('quit'),
                ),
              ) ??
              false;
          if (shouldPop && context.mounted) {
            setState(() {
              _canPop = true;
            });
            context.pop();
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

                return BlocBuilder<QuizSessionIndexCubit, int>(
                  bloc: _indexCubit,
                  builder: (context, currentIndex) {
                    final isCurrentIndexValid = currentIndex < questions.length;
                    final totalQuestions =
                        state.uiModel?.totalQuestions ?? questions.length;
                    final progress = (currentIndex + 1) / totalQuestions;

                    if (!isCurrentIndexValid) {
                      return const LoadingIndicatorWidget();
                    }

                    final currentQuestion = questions[currentIndex];

                    return Column(
                      children: [
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: context.colorScheme.outline
                              .withOpacity(0.2),
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
                                  '${context.tr('question')} ${currentIndex + 1} ${context.tr('of')} $totalQuestions',
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: currentQuestion.choices.map((
                                    choice,
                                  ) {
                                    return BlocSelector<
                                      QuizAnswersCubit,
                                      Map<String, List<String>>,
                                      bool
                                    >(
                                      bloc: _answersCubit,
                                      selector: (selectedAnswers) {
                                        return selectedAnswers[currentQuestion
                                                    .slug]
                                                ?.contains(choice.slug) ??
                                            false;
                                      },
                                      builder: (context, isSelected) {
                                        return ChoiceItem(
                                          choice: choice,
                                          isSelected: isSelected,
                                          isMultiple:
                                              currentQuestion.questionType ==
                                              'multiple',
                                          onTap: () {
                                            _answersCubit.toggleAnswer(
                                              currentQuestion.slug,
                                              choice.slug,
                                              currentQuestion.questionType ==
                                                  'multiple',
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildFooter(
                          context,
                          questions.length,
                          state,
                          currentIndex,
                        ),
                      ],
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    int totalInCurrentList,
    GetQuestionsSuccess state,
    int currentIndex,
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
          if (currentIndex > 0)
            OutlinedButton(
              onPressed: () => _indexCubit.decrement(),
              child: Text(context.tr('previous')),
            )
          else
            const SizedBox.shrink(),
          CustomPrimaryButton(
            text: (currentIndex == totalInCurrentList - 1 && !hasNextPage)
                ? context.tr('submit')
                : context.tr('next'),
            onTap: () {
              if (currentIndex < totalInCurrentList - 1) {
                _indexCubit.increment();
              } else if (hasNextPage) {
                if (!state.isPaginationLoading) {
                  context.read<QuizCourseBloc>().add(
                    GetQuizQuestionsEvent(
                      widget.quizSlug,
                      page: uiModel.currentPage + 1,
                    ),
                  );
                  _indexCubit.increment();
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
