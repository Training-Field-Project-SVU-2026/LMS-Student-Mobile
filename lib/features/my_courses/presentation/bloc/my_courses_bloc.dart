import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_repository.dart';
import 'package:lms_student/features/my_courses/presentation/bloc/my_courses_state.dart';
import 'my_courses_event.dart';

class MyCoursesBloc extends Bloc<MyCoursesEvent, MyCoursesState> {
  final CourseRepository courseRepository;

  MyCoursesBloc({required this.courseRepository})
    : super(const MyCoursesState()) {
    on<GetMyCoursesEvent>(_onGetMyCourses);
    on<SearchMyCoursesEvent>(_onSearchMyCourses);
    on<FilterMyCoursesEvent>(_onFilterMyCourses);
  }

  Future<void> _onGetMyCourses(
    GetMyCoursesEvent event,
    Emitter<MyCoursesState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(status: MyCoursesStatus.loading));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    try {
      final result = await courseRepository.getMyEnrollments(
        page: event.page,
        pageSize: event.pageSize,
      );

      result.fold(
        (error) => emit(
          state.copyWith(
            status: MyCoursesStatus.error,
            errorMessage: error,
            isPaginationLoading: false,
          ),
        ),
        (newModel) {
          if (event.page == 1) {
            emit(
              state.copyWith(
                status: MyCoursesStatus.loaded,
                enrollmentsUIModel: newModel,
                isPaginationLoading: false,
              ),
            );
          } else {
            final currentModel = state.enrollmentsUIModel;
            final updatedModel = newModel.copyWithItems(
              [...currentModel?.courses ?? [], ...newModel.courses],
              totalPages: newModel.totalPages,
              currentPage: newModel.currentPage,
              totalCourses: newModel.totalCourses,
            );
            emit(
              state.copyWith(
                status: MyCoursesStatus.loaded,
                enrollmentsUIModel: updatedModel,
                isPaginationLoading: false,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MyCoursesStatus.error,
          errorMessage: e.toString(),
          isPaginationLoading: false,
        ),
      );
    }
  }

  void _onSearchMyCourses(
    SearchMyCoursesEvent event,
    Emitter<MyCoursesState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onFilterMyCourses(
    FilterMyCoursesEvent event,
    Emitter<MyCoursesState> emit,
  ) {
    emit(state.copyWith(filterStatus: event.status));
  }
}
