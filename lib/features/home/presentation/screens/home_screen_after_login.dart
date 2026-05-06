import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/routing/router_generator.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';

import 'package:lms_student/features/home/presentation/bloc/home_bloc.dart';
import 'package:lms_student/features/home/presentation/get_data_from_cache.dart';

import 'package:lms_student/features/widgets/loading_indicator_widget.dart';
import 'package:lms_student/features/widgets/error_feedback_widget.dart';
import 'package:lms_student/features/widgets/course_card_horizontal.dart';
import 'package:lms_student/features/widgets/course_card_vertical.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/widgets/custom_image.dart';

class HomeScreenAfterLogin extends StatefulWidget {
  // final int completedVideos;
  // final int totalVideos;

  const HomeScreenAfterLogin({super.key});

  @override
  State<HomeScreenAfterLogin> createState() => _HomeScreenAfterLoginState();
}

class _HomeScreenAfterLoginState extends State<HomeScreenAfterLogin> with RouteAware {
  // double progress = completedVideos / totalVideos;

  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<HomeBloc>().state;
      if (state.enrollmentsStatus == RequestStatus.loaded &&
          !state.isEnrollmentsPaginationLoading &&
          (state.enrollmentsUIModel?.currentPage ?? 0) <
              (state.enrollmentsUIModel?.totalPages ?? 0)) {
        context.read<HomeBloc>().add(
          GetMyEnrollmentsEvent(
            page: (state.enrollmentsUIModel?.currentPage ?? 0) + 1,
          ),
        );
      }
    }
  }

  void loadData() {
    context.read<HomeBloc>().add(const GetCoursesEvent());
    context.read<HomeBloc>().add(const GetMyEnrollmentsEvent());
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    homeRouteObserver.unsubscribe(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        loadData();
      },
      child: ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.secondary,
                  ),
                  child: CustomImage(
                    imagePath: getDataFromCache(ApiKey.image),
                    width: 44.w,
                    height: 44.h,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('welcome_back_comma'),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                    Text(
                      "${getDataFromCache(ApiKey.firstName)} ${getDataFromCache(ApiKey.lastName)}",
                      style: context.textTheme.titleLarge!.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.notifications_outlined,
                  size: 24.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.enrollmentsStatus == RequestStatus.loading) {
                  return const LoadingIndicatorWidget();
                }
                if (state.enrollmentsStatus == RequestStatus.error) {
                  return ErrorFeedbackWidget(
                    errorMessage: state.enrollmentsErrorMessage ?? 'Error',
                    onRetry: () {
                      context.read<HomeBloc>().add(const GetMyEnrollmentsEvent());
                    },
                  );
                }
                if (state.enrollmentsStatus == RequestStatus.loaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h),
                      Text(
                        context.tr('my_courses'),
                        style: context.textTheme.titleLarge!.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 5.h),

                      if (state.enrollments.isEmpty)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50.h),

                              Icon(
                                Icons.error_outline,
                                size: 64.sp,
                                color: context.colorScheme.error,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                context.tr('no_courses_yet'),
                                style: context.textTheme.bodyLarge,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                context.tr('explore_courses_to_start'),
                                style: context.textTheme.bodySmall,
                              ),
                              SizedBox(height: 150.h),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.enrollments.length,
                              itemBuilder: (context, index) {
                                final course = state.enrollments[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  child: InkWell(
                                    onTap: () {
                                      log(
                                        "tahaaaaaaaaaaaaaaaa22 ${course.instructorName}",
                                      );
                                      context.push(
                                        AppRoutes.courseDetailsScreen,
                                        extra: {
                                          'slug': course.slug,
                                          'isEnrolled': true,
                                        },
                                      );
                                    },
                                    child: CourseCardHorizontal(
                                      progressPercentage: course.progress,
                                      progressValue: course.progress!.toDouble(),
                                      title: course.title,
                                      instructorName: course.instructorName,
                                      imagePath: course.image,
                                      rating: course.avgRating,
                                      width: 200.w,
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (state.isEnrollmentsPaginationLoading)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        ),
                      SizedBox(height: 20.h),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          // BlocBuilder للكورسات (Courses)
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.coursesStatus == RequestStatus.loading) {
                  return const LoadingIndicatorWidget();
                }
                if (state.coursesStatus == RequestStatus.error) {
                  return ErrorFeedbackWidget(
                    errorMessage: state.coursesErrorMessage ?? 'Error',
                    onRetry: () {
                      context.read<HomeBloc>().add(const GetCoursesEvent());
                    },
                  );
                }
                if (state.coursesStatus == RequestStatus.loaded) {
                  log("courses from bloc: ${state.courses}");
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  context.tr('featured_courses'),
                                  style: context.textTheme.titleLarge!.copyWith(
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                context.push(AppRoutes.viewAllCourse);
                              },
                              child: Text(
                                context.tr('view_all'),
                                style: context.textTheme.labelLarge!.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: state.courses.map((course) {
                              return Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: InkWell(
                                  onTap: () {
                                    log('Course slugggggggggg: ${course.slug}');
                                    context.push(
                                      AppRoutes.courseDetailsScreen,
                                      extra: {
                                        'slug': course.slug,
                                        'isEnrolled': course.isenrolled,
                                      },
                                    );
                                  },
                                  child: CourseCardVertical(
                                    title: course.title,
                                    price: course.price,
                                    imagePath: course.image,
                                    rating: course.avgRating,
                                    totalStudents: course.studentsCount,
                                    description: course.description,
                                    instructorName: course.instructorName,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
