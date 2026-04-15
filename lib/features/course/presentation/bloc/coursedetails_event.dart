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
  final CourseModel course;

  const EnrollCourse({required this.slug, required this.course});

  @override
  List<Object> get props => [slug, course];
}
