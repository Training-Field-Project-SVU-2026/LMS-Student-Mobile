import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
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
    emit(state.copyWith(coursesStatus: RequestStatus.loading));

    try {
      final result = await courseRepository.getAllCourses();

      result.fold(
        (error) => emit(
          state.copyWith(
            coursesStatus: RequestStatus.error,
            coursesErrorMessage: error,
          ),
        ),
        (response) => emit(
          state.copyWith(
            coursesStatus: RequestStatus.loaded,
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
          coursesStatus: RequestStatus.error,
          coursesErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetMyEnrollments(
    GetMyEnrollmentsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(enrollmentsStatus: RequestStatus.loading));

    try {
      final result = await courseRepository.getMyEnrollments();

      result.fold(
        (error) => emit(
          state.copyWith(
            enrollmentsStatus: RequestStatus.error,
            enrollmentsErrorMessage: error,
          ),
        ),
        (response) => emit(
          state.copyWith(
            enrollmentsStatus: RequestStatus.loaded,
            enrollments: response.data,
            enrollmentsTotalPages: response.totalPages,
            enrollmentsCurrentPage: response.currentPage,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          enrollmentsStatus: RequestStatus.error,
          enrollmentsErrorMessage: e.toString(),
        ),
      );
    }
  }
}
