import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/course/presentation/bloc/coursedetails_bloc.dart';
import 'package:lms_student/features/course/presentation/screens/widget/custom_img.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String? slug;
  final bool? isenroll;
  const CourseDetailsScreen({super.key, this.slug, this.isenroll});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
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
        if (widget.isenroll == true) {
          Future.microtask(() {
            if (mounted) {
              context.pushReplacement(
                AppRoutes.courseAfterEnroll,
                extra: widget.slug,
              );
            }
          });
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(context.tr('course_details')),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share_outlined, size: 33.sp),
              ),
            ],
          ),
          body: (() {
            if (state is CourseLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CourseError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.slug != null) {
                          context.read<CoursedetailsBloc>().add(
                            GetCourseDetails(slug: widget.slug!),
                          );
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is CourseLoaded) {
              final course = state.course;
              return Column(
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
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "${course.avgRating}",
                                    style: context.textTheme.headlineSmall!
                                        .copyWith(
                                          color: context.colorScheme.onSurface,
                                        ),
                                  ),
                                ],
                              ),

                              Text(
                                course.title,
                                style: context.textTheme.displayMedium!
                                    .copyWith(
                                      color: context.colorScheme.primary,
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "\$${course.price.toInt()}",
                                style: context.textTheme.headlineLarge!
                                    .copyWith(
                                      color: context.colorScheme.onSurface
                                          .withValues(alpha: 0.5),
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                context.tr('about_this_course'),
                                style: context.textTheme.titleLarge!.copyWith(
                                  color: context.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                course.description,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                context.tr('instructor'),
                                style: context.textTheme.titleLarge!.copyWith(
                                  color: context.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: context.colorScheme.onSurface
                                            .withValues(alpha: 0.2),
                                        width: 1.w,
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
                                                  .titleLarge!
                                                  .copyWith(
                                                    color: context
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                            ),
                                            Text(
                                              course.instructorBio,
                                              style: context
                                                  .textTheme
                                                  .labelLarge!
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
                                  SizedBox(height: 15.h),
                                  Text(
                                    course.instructorBio,
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                          color: context.colorScheme.onSurface
                                              .withValues(alpha: 0.5),
                                        ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16.h,
                                    horizontal: 20.w,
                                  ),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${course.avgRating}",
                                              style: context
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(
                                                    color: context
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                            ),
                                            Text(
                                              context.tr('rating'),
                                              style: context
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                    color: context
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${course.studentsCount}",
                                              style: context
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(
                                                    color: context
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                            ),
                                            Text(
                                              context.tr('students'),
                                              style: context
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                    color: context
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                    child: CustomPrimaryButton(
                      text: context.tr('enroll_now'),
                      textStyle: context.textTheme.labelLarge!.copyWith(
                        fontSize: 16.sp,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              title: Column(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: context.colorScheme.secondary,
                                    size: 60.sp,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    context.tr('enroll_success_title'),
                                    style: context.textTheme.displayMedium!
                                        .copyWith(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                          color: context.colorScheme.secondary,
                                        ),
                                  ),
                                ],
                              ),
                              content: Text(
                                context.tr('enroll_success_message'),
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyLarge,
                              ),
                              actions: [
                                Center(
                                  child: CustomPrimaryButton(
                                    text: context.tr('go_to_course'),
                                    textStyle: context.textTheme.labelLarge!
                                        .copyWith(fontSize: 16.sp),
                                    onTap: () {
                                      context.read<CoursedetailsBloc>().add(
                                        EnrollCourse(slug: course.slug),
                                      );
                                      context.pushReplacement(
                                        AppRoutes.courseAfterEnroll,
                                        extra: course.slug,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            ); // initial state
          })(),
        );
      },
    );
  }
}
