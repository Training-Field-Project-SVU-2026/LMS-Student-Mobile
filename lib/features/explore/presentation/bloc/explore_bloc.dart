import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_repository.dart';
import 'package:lms_student/core/common_logic/domain/repositories/package_repository.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';
import 'package:lms_student/features/explore/domain/repositories/explore_repository.dart';

part 'explore_event.dart';
part 'explore_state.dart';

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
    emit(state.copyWith(packageStatus: ExploreStatus.loading));

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
          ),
        ),
        (packages) => emit(
          state.copyWith(
            packageStatus: ExploreStatus.success,
            packages: packages,
          ),
        ),
      );

    } catch (e) {
      emit(
        state.copyWith(
          packageStatus: ExploreStatus.failure,
          packageError: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetCourses(
    GetCoursesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(courseStatus: ExploreStatus.loading));

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
          ),
        ),
        (response) => emit(
          state.copyWith(
            courseStatus: ExploreStatus.success,
            courses: response.data,
            totalCourses: response.totalCourses,
            totalPages: response.totalPages,
            currentPage: response.currentPage,
          ),
        ),
      );

    } catch (e) {
      emit(
        state.copyWith(
          courseStatus: ExploreStatus.failure,
          courseError: e.toString(),
        ),
      );
    }
  }
}
