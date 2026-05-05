part of 'home_bloc.dart';

enum RequestStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final RequestStatus coursesStatus;
  final CoursePaginatedUIModel? coursesUIModel;
  final String? coursesErrorMessage;
  final bool isCoursesPaginationLoading;

  final RequestStatus enrollmentsStatus;
  final CoursePaginatedUIModel? enrollmentsUIModel;
  final String? enrollmentsErrorMessage;
  final bool isEnrollmentsPaginationLoading;

  const HomeState({
    this.coursesStatus = RequestStatus.initial,
    this.coursesUIModel,
    this.coursesErrorMessage,
    this.isCoursesPaginationLoading = false,
    this.enrollmentsStatus = RequestStatus.initial,
    this.enrollmentsUIModel,
    this.enrollmentsErrorMessage,
    this.isEnrollmentsPaginationLoading = false,
  });

  List<CourseModel> get courses => coursesUIModel?.courses ?? [];
  List<CourseModel> get enrollments => enrollmentsUIModel?.courses ?? [];

  HomeState copyWith({
    RequestStatus? coursesStatus,
    CoursePaginatedUIModel? coursesUIModel,
    String? coursesErrorMessage,
    bool? isCoursesPaginationLoading,
    RequestStatus? enrollmentsStatus,
    CoursePaginatedUIModel? enrollmentsUIModel,
    String? enrollmentsErrorMessage,
    bool? isEnrollmentsPaginationLoading,
  }) {
    return HomeState(
      coursesStatus: coursesStatus ?? this.coursesStatus,
      coursesUIModel: coursesUIModel ?? this.coursesUIModel,
      coursesErrorMessage: coursesErrorMessage ?? this.coursesErrorMessage,
      isCoursesPaginationLoading:
          isCoursesPaginationLoading ?? this.isCoursesPaginationLoading,
      enrollmentsStatus: enrollmentsStatus ?? this.enrollmentsStatus,
      enrollmentsUIModel: enrollmentsUIModel ?? this.enrollmentsUIModel,
      enrollmentsErrorMessage:
          enrollmentsErrorMessage ?? this.enrollmentsErrorMessage,
      isEnrollmentsPaginationLoading:
          isEnrollmentsPaginationLoading ?? this.isEnrollmentsPaginationLoading,
    );
  }

  @override
  List<Object?> get props => [
        coursesStatus,
        coursesUIModel,
        coursesErrorMessage,
        isCoursesPaginationLoading,
        enrollmentsStatus,
        enrollmentsUIModel,
        enrollmentsErrorMessage,
        isEnrollmentsPaginationLoading,
      ];
}
