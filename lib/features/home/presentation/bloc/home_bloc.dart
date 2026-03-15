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
    : super(CoursesInitial()) {
    on<GetCoursesEvent>(_onGetCourses);
  }

  Future<void> _onGetCourses(
    GetCoursesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(CoursesLoading());

    try {
      final result = await courseRepository.getAllCourses();

      result.fold(
        (response) => emit(
          CoursesLoaded(
            courses: response.data,
            totalCourses: response.totalCourses,
            totalPages: response.totalPages,
            currentPage: response.currentPage,
          ),
        ),
        (error) => emit(CoursesError(message: error)),
      );
    } catch (e) {
      emit(CoursesError(message: e.toString()));
    }
  }
}
