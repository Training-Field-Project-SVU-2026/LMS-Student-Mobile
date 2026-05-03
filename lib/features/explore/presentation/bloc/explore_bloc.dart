import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_repository.dart';
import 'package:lms_student/core/common_logic/domain/repositories/package_repository.dart';

import 'package:lms_student/features/explore/domain/repositories/explore_repository.dart';
import 'package:lms_student/features/explore/presentation/bloc/explore_event.dart';

import 'package:lms_student/features/explore/presentation/bloc/explore_state.dart';


class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ExploreRepository exploreRepository;
  final PackageRepository packageRepository;
  final CourseRepository courseRepository;

  ExploreBloc({
    required this.exploreRepository,
    required this.packageRepository,
    required this.courseRepository,
  }) : super(ExploreState.initial()) {
    on<GetpackagesEvent>(_onGetPackages);
    on<GetCoursesEvent>(_onGetCourses);
  }

  Future<void> _onGetPackages(
    GetpackagesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(packageStatus: ExploreStatus.loading));
    } else {
      emit(state.copyWith(isPackagePaginationLoading: true));
    }

    try {
      final response = await packageRepository.getAllPackages(
        page: event.page,
        pageSize: event.pageSize,
      );
      response.fold(
        (error) => emit(
          state.copyWith(
            packageStatus: ExploreStatus.failure,
            packageError: error,
            isPackagePaginationLoading: false,
          ),
        ),
        (newModel) {
          if (event.page == 1) {
            emit(
              state.copyWith(
                packageStatus: ExploreStatus.success,
                packageUIModel: newModel,
                isPackagePaginationLoading: false,
              ),
            );
          } else {
            final currentModel = state.packageUIModel;
            final updatedModel = newModel.copyWithItems(
              [...currentModel?.packages ?? [], ...newModel.packages],
              totalPages: newModel.totalPages,
              currentPage: newModel.currentPage,
              totalPackages: newModel.totalPackages,
            );
            emit(
              state.copyWith(
                packageStatus: ExploreStatus.success,
                packageUIModel: updatedModel,
                isPackagePaginationLoading: false,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          packageStatus: ExploreStatus.failure,
          packageError: e.toString(),
          isPackagePaginationLoading: false,
        ),
      );
    }
  }

  Future<void> _onGetCourses(
    GetCoursesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(courseStatus: ExploreStatus.loading));
    } else {
      emit(state.copyWith(isCoursePaginationLoading: true));
    }

    try {
      final result = await courseRepository.getAllCourses(
        page: event.page,
        pageSize: event.pageSize,
      );

      result.fold(
        (error) => emit(
          state.copyWith(
            courseStatus: ExploreStatus.failure,
            courseError: error,
            isCoursePaginationLoading: false,
          ),
        ),
        (newModel) {
          if (event.page == 1) {
            emit(
              state.copyWith(
                courseStatus: ExploreStatus.success,
                courseUIModel: newModel,
                isCoursePaginationLoading: false,
              ),
            );
          } else {
            final currentModel = state.courseUIModel;
            final updatedModel = newModel.copyWithItems(
              [...currentModel?.courses ?? [], ...newModel.courses],
              totalPages: newModel.totalPages,
              currentPage: newModel.currentPage,
              totalCourses: newModel.totalCourses,
            );
            emit(
              state.copyWith(
                courseStatus: ExploreStatus.success,
                courseUIModel: updatedModel,
                isCoursePaginationLoading: false,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          courseStatus: ExploreStatus.failure,
          courseError: e.toString(),
          isCoursePaginationLoading: false,
        ),
      );
    }
  }
}
