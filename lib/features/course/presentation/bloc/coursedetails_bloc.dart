import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_repository.dart';

part 'coursedetails_event.dart';
part 'coursedetails_state.dart';

class CoursedetailsBloc extends Bloc<CoursedetailsEvent, CoursedetailsState> {
  final CourseRepository courseRepository;

  CoursedetailsBloc({required this.courseRepository})
    : super(CoursedetailsInitial()) {
    on<GetCourseDetails>((event, emit) async {
      emit(CourseLoading());

      try {
        final result = await courseRepository.getCourseBySlug(event.slug);
        result.fold(
          (error) {
            emit(CourseError(message: error));
          },
          (course) {
            emit(CourseLoaded(course: course.data));
          },
        );
      } catch (e) {
        emit(CourseError(message: 'error: ${e.toString()}'));
      }
    });
  }
}
