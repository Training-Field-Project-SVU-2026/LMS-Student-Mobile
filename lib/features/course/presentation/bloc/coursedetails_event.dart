// coursedetails_event.dart
part of 'coursedetails_bloc.dart';

sealed class CoursedetailsEvent extends Equatable {
  const CoursedetailsEvent();

  @override
  List<Object> get props => [];
}

class GetCourseDetails extends CoursedetailsEvent {
  final String slug;

  const GetCourseDetails({required this.slug});

  @override
  List<Object> get props => [slug];
}

class EnrollCourse extends CoursedetailsEvent {
  final String slug;

  const EnrollCourse({required this.slug});

  @override
  List<Object> get props => [slug];
}
