import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/course/presentation/bloc/coursedetails_bloc.dart';
import 'package:lms_student/features/course/presentation/screens/widget/custom_course_material.dart';
import 'package:lms_student/features/course/presentation/screens/widget/custom_img.dart';

class CourseAfterEnroll extends StatefulWidget {
  final String? slug;

  const CourseAfterEnroll({super.key, this.slug});

  @override
  State<CourseAfterEnroll> createState() => _CourseAfterEnrollState();
}

class _CourseAfterEnrollState extends State<CourseAfterEnroll> {
  @override
  void initState() {
    super.initState();
    if (widget.slug != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<CoursedetailsBloc>().add(
            GetCourseDetails(slug: widget.slug!),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursedetailsBloc, CoursedetailsState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CourseError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.slug != null) {
                        context.read<CoursedetailsBloc>().add(
                          GetCourseDetails(slug: widget.slug!),
                        );
                      }
                    },
                    child: Text(context.tr('retry')),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is CourseLoaded) {
          final course = state.course;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(course.title, overflow: TextOverflow.ellipsis),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined, size: 33.sp),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      CustomImg(imgUrl: course.image),
                      Padding(
                        padding: EdgeInsetsGeometry.all(20.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: context.textTheme.displayLarge!.copyWith(
                                fontSize: 40.sp,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing: 16.w,
                                children: [
                                  CustomCourseMaterial(
                                    onTap: () {},
                                    text: context.tr('videos'),
                                    icon: Icons.play_circle,
                                  ),
                                  CustomCourseMaterial(
                                    onTap: () {},
                                    text: context.tr('files'),
                                    icon: Icons.folder,
                                  ),
                                  CustomCourseMaterial(
                                    onTap: () {},
                                    text: context.tr('quizzes'),
                                    icon: Icons.quiz,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              context.tr('about_this_course'),
                              style: context.textTheme.displayMedium!.copyWith(
                                fontSize: 28.sp,
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              course.description,
                              style: context.textTheme.titleLarge!.copyWith(
                                color: context.colorScheme.onSurface,
                              ),
                            ),

                            Text(
                              context.tr('instructor'),
                              style: context.textTheme.displayMedium!.copyWith(
                                fontSize: 26.sp,
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),

                            SizedBox(height: 15.h),
                            Column(
                              children: [
                                Container(
                                  width: 350.w,
                                  height: 86.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.colorScheme.onSurface
                                          .withValues(alpha: 0.2),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  padding: EdgeInsets.all(12.r),
                                  child: Row(
                                    children: [
                                      CustomImg(
                                        radius: 15,
                                        height: 56.h,
                                        width: 56.w,
                                        imgUrl: course.instructorImage,
                                      ),
                                      SizedBox(width: 16.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            course.instructorName,
                                            style: context
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                  color: context
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                          Text(
                                            course.instructorBio,
                                            style: context.textTheme.labelLarge!
                                                .copyWith(
                                                  color: context
                                                      .colorScheme
                                                      .onSurface
                                                      .withValues(alpha: 0.3),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(body: const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
