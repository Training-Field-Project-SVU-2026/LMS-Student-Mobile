import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_list_mixin.dart';
import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_state.dart';
import 'package:lms_student/features/quiz_course/data/model/quiz_model.dart';
import 'package:lms_student/features/quiz_course/data/model/question_model.dart';
import 'package:lms_student/features/quiz_course/data/model/attempt_result_model.dart';
import 'package:lms_student/features/quiz_course/domain/repository/quiz_course_repository.dart';
import 'package:lms_student/features/quiz_course/domain/entity/quiz_paginated_ui_model.dart';
import 'package:lms_student/features/quiz_course/domain/entity/question_paginated_ui_model.dart';

part 'quiz_course_event.dart';
part 'quiz_course_state.dart';

class QuizCourseBloc extends Bloc<QuizCourseEvent, QuizCourseState>
    with
        PaginatedListMixin<
            QuizCourseEvent,
            QuizCourseState,
            QuizModel,
            QuizPaginatedUIModel,
            GetQuizzesSuccess,
            GetQuizzesError,
            GetQuizzesLoading> {
  final QuizCourseRepository repository;

  QuizCourseBloc({required this.repository}) : super(QuizCourseInitial()) {
    on<GetQuizzesByCourseEvent>(_onGetQuizzes);
    on<GetQuizQuestionsEvent>(_onGetQuestions);
    on<SubmitQuizEvent>(_onSubmitQuiz);
    on<GetQuizResultsEvent>(_onGetResults);
  }

  Future<void> _onGetQuizzes(GetQuizzesByCourseEvent event, Emitter<QuizCourseState> emit) async {
    if (event.page == 1) {
      emit(GetQuizzesLoading());
    } else {
      if (state is GetQuizzesSuccess) {
        emit(GetQuizzesSuccess((state as GetQuizzesSuccess).uiModel, isPaginationLoading: true));
      }
    }

    final result = await repository.getQuizzesByCourse(event.courseSlug, page: event.page);

    result.fold(
      (error) => emit(GetQuizzesError(error)),
      (newEntity) {
        handlePaginatedResponse(
          page: event.page,
          newEntity: newEntity,
          currentState: state,
          emit: emit.call,
          loadedStateBuilder: (model, isPaginating) => GetQuizzesSuccess(model, isPaginationLoading: isPaginating),
          errorStateBuilder: (msg) => GetQuizzesError(msg),
          loadingStateBuilder: () => GetQuizzesLoading(),
        );
      },
    );
  }

  Future<void> _onGetQuestions(GetQuizQuestionsEvent event, Emitter<QuizCourseState> emit) async {
    if (event.page == 1) {
      emit(GetQuestionsLoading());
    } else {
      if (state is GetQuestionsSuccess) {
        emit(GetQuestionsSuccess((state as GetQuestionsSuccess).uiModel, isPaginationLoading: true));
      }
    }

    final result = await repository.getQuizQuestions(event.quizSlug, page: event.page);

    result.fold(
      (error) => emit(GetQuestionsError(error)),
      (newEntity) {
        if (event.page == 1 || state is! GetQuestionsSuccess) {
          emit(GetQuestionsSuccess(newEntity));
        } else {
          final currentModel = (state as GetQuestionsSuccess).uiModel;
          if (currentModel != null) {
            final accumulatedItems = [...currentModel.items, ...newEntity.items];
            final updatedModel = newEntity.copyWithItems(
              accumulatedItems,
              totalPages: newEntity.totalPages,
              currentPage: newEntity.currentPage,
            );
            emit(GetQuestionsSuccess(updatedModel));
          } else {
            emit(GetQuestionsSuccess(newEntity));
          }
        }
      },
    );
  }

  Future<void> _onSubmitQuiz(SubmitQuizEvent event, Emitter<QuizCourseState> emit) async {
    emit(SubmitQuizLoading());
    final result = await repository.submitQuiz(event.quizSlug, {'answers': event.answers});
    result.fold(
      (error) => emit(SubmitQuizError(error)),
      (response) {
        emit(SubmitQuizSuccess(response.data));
      },
    );
  }

  Future<void> _onGetResults(GetQuizResultsEvent event, Emitter<QuizCourseState> emit) async {
    emit(GetResultsLoading());
    final result = await repository.getQuizResults(event.quizSlug);
    result.fold(
      (error) => emit(GetResultsError(error)),
      (response) => emit(GetResultsSuccess(response.data)),
    );
  }
}