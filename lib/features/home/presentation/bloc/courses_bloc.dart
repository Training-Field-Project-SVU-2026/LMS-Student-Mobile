import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_student/features/home/data/model/course_model.dart';
import 'package:lms_student/features/home/domain/repositories/home_repository.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final HomeRepository homeRepository;

  CoursesBloc({required this.homeRepository}) : super(CoursesInitial()) {
    // 🟢 Event واحد بس
    on<FetchCoursesEvent>((event, emit) async {
      emit(CoursesLoading()); // 🔵 نشغل التحميل

      try {
        final result = await homeRepository.getAllCourses();

        result.fold(
          (courses) => emit(CoursesLoaded(courses: courses)), // 🟢 نجاح
          (error) => emit(CoursesError(message: error)), // 🔴 فشل
        );
      } catch (e) {
        emit(CoursesError(message: e.toString()));
      }
    });
  }
}
