import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/common/data/model/course_model.dart';
import 'package:lms_student/features/common/domain/repositories/course_repository.dart';
import 'package:lms_student/features/home/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CourseRepository courseRepository;
  final HomeRepository homeRepository;

  HomeBloc({required this.courseRepository, required this.homeRepository})
    : super(CoursesInitial()) {
    on<GetCoursesEvent>((event, emit) async {
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
    });
  }
}
