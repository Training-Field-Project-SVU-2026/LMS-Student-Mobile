import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_paginated_ui_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_repository.dart';
import 'package:lms_student/features/home/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CourseRepository courseRepository;
  final HomeRepository homeRepository;

  HomeBloc({required this.courseRepository, required this.homeRepository})
    : super(const HomeState()) {
    on<GetCoursesEvent>(_onGetCourses);
    on<GetMyEnrollmentsEvent>(_onGetMyEnrollments);
  }

  Future<void> _onGetCourses(
    GetCoursesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(coursesStatus: RequestStatus.loading));
    } else {
      emit(state.copyWith(isCoursesPaginationLoading: true));
    }

    try {
      final result = await courseRepository.getAllCourses(
        page: event.page,
        pageSize: event.pageSize,
      );

      result.fold(
        (error) => emit(
          state.copyWith(
            coursesStatus: RequestStatus.error,
            coursesErrorMessage: error,
            isCoursesPaginationLoading: false,
          ),
        ),
        (newModel) {
          if (event.page == 1) {
            emit(
              state.copyWith(
                coursesStatus: RequestStatus.loaded,
                coursesUIModel: newModel,
                isCoursesPaginationLoading: false,
              ),
            );
          } else {
            final currentModel = state.coursesUIModel;
            final updatedModel = newModel.copyWithItems(
              [...currentModel?.courses ?? [], ...newModel.courses],
              totalPages: newModel.totalPages,
              currentPage: newModel.currentPage,
              totalCourses: newModel.totalCourses,
            );
            emit(
              state.copyWith(
                coursesStatus: RequestStatus.loaded,
                coursesUIModel: updatedModel,
                isCoursesPaginationLoading: false,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          coursesStatus: RequestStatus.error,
          coursesErrorMessage: e.toString(),
          isCoursesPaginationLoading: false,
        ),
      );
    }
  }

  Future<void> _onGetMyEnrollments(
    GetMyEnrollmentsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(enrollmentsStatus: RequestStatus.loading));
    } else {
      emit(state.copyWith(isEnrollmentsPaginationLoading: true));
    }

    try {
      final result = await courseRepository.getMyEnrollments(
        page: event.page,
        pageSize: event.pageSize,
      );

      result.fold(
        (error) => emit(
          state.copyWith(
            enrollmentsStatus: RequestStatus.error,
            enrollmentsErrorMessage: error,
            isEnrollmentsPaginationLoading: false,
          ),
        ),
        (newModel) {
          if (event.page == 1) {
            emit(
              state.copyWith(
                enrollmentsStatus: RequestStatus.loaded,
                enrollmentsUIModel: newModel,
                isEnrollmentsPaginationLoading: false,
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
                enrollmentsStatus: RequestStatus.loaded,
                enrollmentsUIModel: updatedModel,
                isEnrollmentsPaginationLoading: false,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          enrollmentsStatus: RequestStatus.error,
          enrollmentsErrorMessage: e.toString(),
          isEnrollmentsPaginationLoading: false,
        ),
      );
    }
  }
}
