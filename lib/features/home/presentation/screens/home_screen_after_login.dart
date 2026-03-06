import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/home/widgets/custom_progress.dart';
import 'package:lms_student/features/home/widgets/custom_streak.dart';
import 'package:lms_student/features/widgets/course_card_horizontal.dart';
import 'package:lms_student/features/widgets/course_card_vertical.dart';

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
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.secondary,
                    ),
                    child: Image.asset(
                      'assets/images/download.jpg',
                      width: 44.w,
                      height: 44.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    children: [
                      Text(
                        'Welcome back,',
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),

                      Text(
                        'Mayoora!',
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontSize: 20.sp,
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
              SizedBox(height: 20.h),
              CustomProgress(),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomStreak(
                    hidtag: "Current Streak",
                    body: "Days",
                    color_container: Color(0xffFBE7D3),
                    color_Icon: const Color(0xffF05A0C),
                    icon: Icons.local_fire_department,
                    days_Or_hours: 5,
                  ),
                  CustomStreak(
                    hidtag: "Hours Today",
                    body: "hrs",
                    color_container: Color(0xffDBEAFE),
                    color_Icon: Color(0xff2563EB),
                    icon: Icons.access_time_outlined,
                    days_Or_hours: 3,
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Text(
                "My Courses",
                style: context.textTheme.headlineLarge!.copyWith(
                  fontSize: 22.sp,
                  color: context.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 21.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: CourseCardHorizontal(
                      title: 'title',
                      instructorName: 'Mayar',
                      imagePath:
                          'https://i.pinimg.com/1200x/54/6b/8a/546b8a6248d8bb62b223c68703786d8f.jpg',
                      rating: 4.5,
                      width: 200.w,
                    ),
                  );
                },
                itemCount: 5,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Courses",
                    style: context.textTheme.headlineMedium!.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "View All",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  20,
                  (index) => CourseCardVertical(
                    title: 'intro to python ',
                    imagePath:
                        'https://i.pinimg.com/1200x/54/6b/8a/546b8a6248d8bb62b223c68703786d8f.jpg',
                    rating: 4.3,
                    totalHours: 12,
                    width: 256,
                    description:
                        'description description description description description description description description description description description description',
                    instructorName: 'instructor name',
                    lessonsCount: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
