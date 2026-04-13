import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/home/presentation/bloc/home_bloc.dart';
import 'package:lms_student/features/widgets/loading_indicator_widget.dart';
import 'package:lms_student/features/widgets/error_feedback_widget.dart';
import 'package:lms_student/features/widgets/course_card_vertical.dart';

class ViewAllCourse extends StatefulWidget {
  const ViewAllCourse({super.key});

  @override
  State<ViewAllCourse> createState() => _ViewAllCourseState();
}

class _ViewAllCourseState extends State<ViewAllCourse> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetCoursesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('view_course'),
          style: context.textTheme.titleLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.coursesStatus == RequestStatus.loading) {
            return const LoadingIndicatorWidget(height: double.infinity);
          }
          if (state.coursesStatus == RequestStatus.error) {
            return ErrorFeedbackWidget(
              height: double.infinity,
              errorMessage: state.coursesErrorMessage ?? 'Error',
              onRetry: () {
                context.read<HomeBloc>().add(GetCoursesEvent());
              },
            );
          }
          if (state.coursesStatus == RequestStatus.loaded) {
            final courses = state.courses;

            if (courses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school,
                      size: 80.sp,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      context.tr('view_course_notFound'),
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.tr('view_course_nothing_added'),
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.70,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return InkWell(
                    onTap: () {
                      log('Course slug: ${course.slug}');
                      context.push(
                        AppRoutes.courseDetailsScreen,
                        extra: {
                          'slug': course.slug,
                          'isEnrolled': course.isenrolled,
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: CourseCardVertical(
                      title: course.title,
                      price: course.price,
                      imagePath: course.image,
                      rating: course.avgRating ?? 0.0,
                      totalStudents: course.studentsCount ?? 0,
                      width: double.infinity,
                      description: course.description,
                      instructorName: course.instructorName,
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
