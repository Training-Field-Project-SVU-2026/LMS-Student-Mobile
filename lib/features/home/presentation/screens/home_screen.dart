import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/home/widgets/custom_rich_text.dart';
import 'package:lms_student/features/home/widgets/feature_card.dart';
import 'package:lms_student/features/widgets/course_card_horizontal.dart';
import 'package:lms_student/features/widgets/course_card_vertical.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        // الـ Logo على الشمال
        title: Row(
          children: [
            Icon(Icons.settings, color: Colors.green, size: 20.sp),
            SizedBox(width: 6.w),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'S',
                    style: TextStyle(
                      color: context.colorScheme.secondary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'kill',
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'U',
                    style: TextStyle(
                      color: context.colorScheme.secondary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'p.',
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: CustomPrimaryButton(
              color: context.colorScheme.secondary,
              onTap: () {},
              text: "Login",
              textStyle: TextStyle(color: context.colorScheme.onSecondary),
              width: 82,
            ),
          ),
        ],
        backgroundColor: context.colorScheme.surface,
        elevation: 1,
        shadowColor: context.colorScheme.onSurface.withValues(alpha: 0.2),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            height: 580.h,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  CustomRichText(),
                  SizedBox(height: 20.h),
                  Container(
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface.withValues(
                        alpha: 0.04,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Master Python, React, and more with expert-led courses designed specifically for mobilelearners.',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall!.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: CustomPrimaryButton(
                      textStyle: TextStyle(color: context.colorScheme.primary),
                      color: context.colorScheme.onPrimary,
                      text: "Start Learning",
                      //Todo: GO TO LOGIN SCREEN
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: CustomOutlinedButton(
                      text: "Browse Courses",
                      textStyle: TextStyle(color: Colors.white),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        side: BorderSide(
                          width: 4,
                          color: context.colorScheme.surface.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Center(
                    child: Image.asset(
                      "assets/images/Home.png",
                      fit: BoxFit.contain,
                      width: 200.w,
                      height: 120.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
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
                SingleChildScrollView(
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
                SizedBox(height: 40.h),
                FeatureCard(
                  description:
                      'Test your knowledge on the go with real-time feedback and progress tracking.',
                  path: "assets/icons/InteractiveQuizzes.png",
                  title: "Interactive Quizzes",
                ),
                SizedBox(height: 20.h),
                FeatureCard(
                  description:
                      'Test your knowledge on the go with real-time feedback and progress tracking.',
                  path: "assets/icons/DiscussionBoards.png",
                  title: "Discussion Boards",
                ),
                SizedBox(height: 20.h),
                FeatureCard(
                  description:
                      'Test your knowledge on the go with real-time feedback and progress tracking.',
                  path: "assets/icons/DownloadableResources.png",
                  title: "Downloadable Resources",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
