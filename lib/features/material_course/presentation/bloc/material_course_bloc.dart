import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lms_student/core/common_logic/domain/repositories/mixins/paginated_list_mixin.dart';
import 'package:lms_student/features/material_course/domain/entity/course_materials_ui_model.dart';
import 'package:lms_student/features/material_course/domain/repository/material_course_repository.dart';
import 'material_course_event.dart';
import 'material_course_state.dart';


class CourseMaterialsBloc extends Bloc<CourseMaterialsEvent, CourseMaterialsState>
    with
        PaginatedListMixin<
            CourseMaterialsEvent,
            CourseMaterialsState,
            CourseMaterialItemUIModel,
            CourseMaterialsListUIModel,
            CourseMaterialsLoaded,
            CourseMaterialsError,
            CourseMaterialsLoading> {
  final MaterialCourseRepository repository;

  CourseMaterialsBloc({required this.repository})
      : super(CourseMaterialsInitial()) {
    on<GetCourseMaterialsEvent>(_onGetCourseMaterials);
  }

  Future<void> _onGetCourseMaterials(
    GetCourseMaterialsEvent event,
    Emitter<CourseMaterialsState> emit,
  ) async {
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      if (state is! CourseMaterialsLoaded) {
        emit(CourseMaterialsLoading());
      }
    } else {
      emit((state as CourseMaterialsLoaded).copyWith(isPaginationLoading: true));
    }

    final response = await repository.getCourseMaterials(
      slug: event.slug,
      page: pageToFetch,
      pageSize: event.pageSize,
    );

    response.fold(
      (error) => emit(CourseMaterialsError(message: error)),
      (responseModel) {
        handlePaginatedResponse(
          page: pageToFetch,
          newEntity: responseModel.toEntity(),
          currentState: state,
          emit: emit.call,
          loadedStateBuilder: (model, isPaging) =>
              CourseMaterialsLoaded(materialsListUIModel: model, isPaginationLoading: isPaging),
          errorStateBuilder: (msg) => CourseMaterialsError(message: msg),
          loadingStateBuilder: () => CourseMaterialsLoading(),
        );
      },
    );
  }

  
}
