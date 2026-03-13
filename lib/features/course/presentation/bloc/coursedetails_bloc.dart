import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'coursedetails_event.dart';
part 'coursedetails_state.dart';

class CoursedetailsBloc extends Bloc<CoursedetailsEvent, CoursedetailsState> {
  CoursedetailsBloc() : super(CoursedetailsInitial()) {
    on<CoursedetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
