import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';

import 'package:lms_student/features/home/presentation/bloc/home_bloc.dart';

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

class _HomeScreenAfterLoginState extends State<HomeScreenAfterLogin> {
  // double progress = completedVideos / totalVideos;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetCoursesEvent());
    context.read<HomeBloc>().add(GetMyEnrollmentsEvent());
  }

  final user = CacheHelper.getDataString(key: ApiKey.user);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                  imagePath: jsonDecode(user!)['image'],
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
                    "${jsonDecode(user!)['first_name']} ${jsonDecode(user!)['last_name']}",
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
        // BlocBuilder للمسجل فيها (My Enrollments)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              // فقط عندما تتغير حالات الـ MyEnrollments
              return current is MyEnrollmentsLoading ||
                  current is MyEnrollmentsError ||
                  current is MyEnrollmentsLoaded;
            },
            builder: (context, state) {
              if (state is MyEnrollmentsLoading) {
                return SizedBox(
                  height: 280.h,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is MyEnrollmentsError) {
                return SizedBox(
                  height: 280.h,
                  child: Center(child: Text('Error : ${state.message}')),
                );
              }
              if (state is MyEnrollmentsLoaded) {
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

                    // هنا الحالة بتاعة الليست الفاضية
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
                                  AppRoutes.courseAfterEnroll,
                                  extra: course.slug,
                                );
                              },
                              child: CourseCardHorizontal(
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
                    SizedBox(height: 20.h),
                    // باقي الكود (Featured Courses section)
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),

        // BlocBuilder للكورسات (Courses)
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) {
              return current is CoursesLoading ||
                  current is CoursesError ||
                  current is CoursesLoaded;
            },
            builder: (context, state) {
              if (state is CoursesLoading) {
                return SizedBox(
                  height: 280.h,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is CoursesError) {
                return SizedBox(
                  height: 280.h,
                  child: Center(child: Text('Error : ${state.message}')),
                );
              }
              if (state is CoursesLoaded) {
                log("courses from bloc: ${state.courses}");
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: state.courses.map((course) {
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: InkWell(
                            onTap: () {
                              log('Course slug: ${course.slug}');
                              context.push(
                                AppRoutes.courseDetailsScreen,
                                extra: course.slug,
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
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
