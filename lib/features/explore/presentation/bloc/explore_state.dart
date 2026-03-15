part of 'explore_bloc.dart';

enum ExploreStatus { initial, loading, success, failure }

class ExploreState extends Equatable {
  final ExploreStatus packageStatus;
  final List<PackagesModel> packages;
  final String? packageError;

  final ExploreStatus courseStatus;
  final List<CourseModel> courses;
  final String? courseError;

  final int? totalCourses;
  final int? totalPages;
  final int? currentPage;

  const ExploreState({
    this.packageStatus = ExploreStatus.initial,
    this.packages = const [],
    this.packageError,
    this.courseStatus = ExploreStatus.initial,
    this.courses = const [],
    this.courseError,
    this.totalCourses,
    this.totalPages,
    this.currentPage,
  });

  factory ExploreState.initial() => const ExploreState();

  ExploreState copyWith({
    ExploreStatus? packageStatus,
    List<PackagesModel>? packages,
    String? packageError,
    ExploreStatus? courseStatus,
    List<CourseModel>? courses,
    String? courseError,
    int? totalCourses,
    int? totalPages,
    int? currentPage,
  }) {
    return ExploreState(
      packageStatus: packageStatus ?? this.packageStatus,
      packages: packages ?? this.packages,
      packageError: packageError ?? this.packageError,
      courseStatus: courseStatus ?? this.courseStatus,
      courses: courses ?? this.courses,
      courseError: courseError ?? this.courseError,
      totalCourses: totalCourses ?? this.totalCourses,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
        packageStatus,
        packages,
        packageError,
        courseStatus,
        courses,
        courseError,
        totalCourses,
        totalPages,
        currentPage,
      ];
}
