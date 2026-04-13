part of 'home_bloc.dart';

enum RequestStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final RequestStatus coursesStatus;
  final List<CourseModel> courses;
  final String? coursesErrorMessage;
  final int? totalCourses;
  final int? totalPages;
  final int? currentPage;

  final RequestStatus enrollmentsStatus;
  final List<CourseModel> enrollments;
  final String? enrollmentsErrorMessage;
  final int? enrollmentsTotalPages;
  final int? enrollmentsCurrentPage;

  const HomeState({
    this.coursesStatus = RequestStatus.initial,
    this.courses = const [],
    this.coursesErrorMessage,
    this.totalCourses,
    this.totalPages,
    this.currentPage,
    this.enrollmentsStatus = RequestStatus.initial,
    this.enrollments = const [],
    this.enrollmentsErrorMessage,
    this.enrollmentsTotalPages,
    this.enrollmentsCurrentPage,
  });

  HomeState copyWith({
    RequestStatus? coursesStatus,
    List<CourseModel>? courses,
    String? coursesErrorMessage,
    int? totalCourses,
    int? totalPages,
    int? currentPage,
    RequestStatus? enrollmentsStatus,
    List<CourseModel>? enrollments,
    String? enrollmentsErrorMessage,
    int? enrollmentsTotalPages,
    int? enrollmentsCurrentPage,
  }) {
    return HomeState(
      coursesStatus: coursesStatus ?? this.coursesStatus,
      courses: courses ?? this.courses,
      coursesErrorMessage: coursesErrorMessage ?? this.coursesErrorMessage,
      totalCourses: totalCourses ?? this.totalCourses,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      enrollmentsStatus: enrollmentsStatus ?? this.enrollmentsStatus,
      enrollments: enrollments ?? this.enrollments,
      enrollmentsErrorMessage: enrollmentsErrorMessage ?? this.enrollmentsErrorMessage,
      enrollmentsTotalPages: enrollmentsTotalPages ?? this.enrollmentsTotalPages,
      enrollmentsCurrentPage: enrollmentsCurrentPage ?? this.enrollmentsCurrentPage,
    );
  }

  @override
  List<Object?> get props => [
    coursesStatus,
    courses,
    coursesErrorMessage,
    totalCourses,
    totalPages,
    currentPage,
    enrollmentsStatus,
    enrollments,
    enrollmentsErrorMessage,
    enrollmentsTotalPages,
    enrollmentsCurrentPage,
  ];
}
