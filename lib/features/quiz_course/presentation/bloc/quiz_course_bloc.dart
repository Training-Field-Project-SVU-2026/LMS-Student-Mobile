import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_course_event.dart';
part 'quiz_course_state.dart';

class QuizCourseBloc extends Bloc<QuizCourseEvent, QuizCourseState> {
  QuizCourseBloc() : super(QuizCourseInitial()) {
    on<QuizCourseEvent>(_onEvent);
  }

  void _onEvent(QuizCourseEvent event, Emitter<QuizCourseState> emit) {
    emit(QuizCourseInitial());
  }
}