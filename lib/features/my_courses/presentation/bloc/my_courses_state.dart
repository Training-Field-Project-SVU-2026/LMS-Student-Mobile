import 'package:equatable/equatable.dart';
import 'package:lms_student/core/common_logic/data/model/course/course_model.dart';
import 'package:lms_student/core/common_logic/domain/repositories/course_paginated_ui_model.dart';

enum MyCoursesStatus { initial, loading, loaded, error }

class MyCoursesState extends Equatable {
  final MyCoursesStatus status;
  final CoursePaginatedUIModel? enrollmentsUIModel;
  final String? errorMessage;
  final bool isPaginationLoading;
  final String searchQuery;
  final String filterStatus;

  const MyCoursesState({
    this.status = MyCoursesStatus.initial,
    this.enrollmentsUIModel,
    this.errorMessage,
    this.isPaginationLoading = false,
    this.searchQuery = '',
    this.filterStatus = 'All',
  });

  List<CourseModel> get allEnrollments => enrollmentsUIModel?.courses ?? [];

  List<CourseModel> get filteredEnrollments {
    List<CourseModel> list = allEnrollments;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      list = list
          .where((course) =>
              course.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              course.instructorName
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Filter by status
    if (filterStatus == 'Ongoing') {
      list = list.where((course) => (course.progress ?? 0) < 100).toList();
    } else if (filterStatus == 'Completed') {
      list = list.where((course) => (course.progress ?? 0) >= 100).toList();
    }

    return list;
  }

  MyCoursesState copyWith({
    MyCoursesStatus? status,
    CoursePaginatedUIModel? enrollmentsUIModel,
    String? errorMessage,
    bool? isPaginationLoading,
    String? searchQuery,
    String? filterStatus,
  }) {
    return MyCoursesState(
      status: status ?? this.status,
      enrollmentsUIModel: enrollmentsUIModel ?? this.enrollmentsUIModel,
      errorMessage: errorMessage ?? this.errorMessage,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        enrollmentsUIModel,
        errorMessage,
        isPaginationLoading,
        searchQuery,
        filterStatus,
      ];
}
