
import 'package:equatable/equatable.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_paginated_ui_model.dart';
import 'package:lms_student/features/explore/data/model/packages_model.dart';
import 'package:lms_student/features/explore/domain/entity/package_paginated_ui_model.dart';

enum ExploreStatus { initial, loading, success, failure }

class ExploreState extends Equatable {
  final ExploreStatus packageStatus;
  final PackagePaginatedUIModel? packageUIModel;
  final String? packageError;
  final bool isPackagePaginationLoading;

  final ExploreStatus courseStatus;
  final CoursePaginatedUIModel? courseUIModel;
  final String? courseError;
  final bool isCoursePaginationLoading;

  const ExploreState({
    this.packageStatus = ExploreStatus.initial,
    this.packageUIModel,
    this.packageError,
    this.isPackagePaginationLoading = false,
    this.courseStatus = ExploreStatus.initial,
    this.courseUIModel,
    this.courseError,
    this.isCoursePaginationLoading = false,
  });

  factory ExploreState.initial() => const ExploreState();

  List<PackagesModel> get packages => packageUIModel?.packages ?? [];
  List<CourseModel> get courses => courseUIModel?.courses ?? [];

  ExploreState copyWith({
    ExploreStatus? packageStatus,
    PackagePaginatedUIModel? packageUIModel,
    String? packageError,
    bool? isPackagePaginationLoading,
    ExploreStatus? courseStatus,
    CoursePaginatedUIModel? courseUIModel,
    String? courseError,
    bool? isCoursePaginationLoading,
  }) {
    return ExploreState(
      packageStatus: packageStatus ?? this.packageStatus,
      packageUIModel: packageUIModel ?? this.packageUIModel,
      packageError: packageError ?? this.packageError,
      isPackagePaginationLoading:
          isPackagePaginationLoading ?? this.isPackagePaginationLoading,
      courseStatus: courseStatus ?? this.courseStatus,
      courseUIModel: courseUIModel ?? this.courseUIModel,
      courseError: courseError ?? this.courseError,
      isCoursePaginationLoading:
          isCoursePaginationLoading ?? this.isCoursePaginationLoading,
    );
  }

  @override
  List<Object?> get props => [
        packageStatus,
        packageUIModel,
        packageError,
        isPackagePaginationLoading,
        courseStatus,
        courseUIModel,
        courseError,
        isCoursePaginationLoading,
      ];
}
