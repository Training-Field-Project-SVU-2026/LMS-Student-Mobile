import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/theme/app_assets.dart';
import 'package:lms_student/features/home/presentation/bloc/home_bloc.dart';
import 'package:lms_student/features/home/widgets/custom_rich_text.dart';
import 'package:lms_student/features/home/widgets/feature_card.dart';
import 'package:lms_student/features/widgets/course_card_vertical.dart';
import 'package:lms_student/features/widgets/custom_outlined_button.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class HomeScreenBeforeLogin extends StatefulWidget {
  const HomeScreenBeforeLogin({super.key});

  @override
  State<HomeScreenBeforeLogin> createState() => _HomeScreenBeforeLoginState();
}

class _HomeScreenBeforeLoginState extends State<HomeScreenBeforeLogin> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetCoursesEvent());
  }

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
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              onTap: () {
                context.push(AppRoutes.loginScreen);
              },
              text: context.tr('login'),
              textStyle: TextStyle(color: context.colorScheme.onSurface),

              width: 120,
              height: 40,
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
                  Center(
                    child: Container(
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
                          context.tr('master_python_react'),
                          maxLines: 3,

                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelSmall!.copyWith(
                            color: context.colorScheme.surface,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: CustomPrimaryButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      textStyle: TextStyle(color: context.colorScheme.primary),

                      text: context.tr('start_learning'),
                      //Todo: GO TO LOGIN SCREEN
                      onTap: () {
                        context.push(AppRoutes.loginScreen);
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: CustomOutlinedButton(
                      text: context.tr('browse_courses'),
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
                      AppAssets.homePng,
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
                      context.tr('featured_courses'),
                      style: context.textTheme.headlineMedium!.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      context.tr('view_all'),
                      style: context.textTheme.labelMedium!.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is CoursesLoading) {
                      return Container(
                        height: 280.h,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is CoursesError) {
                      return Container(
                        height: 280.h,
                        child: Center(child: Text('Error : ${state.message}')),
                      );
                    }
                    if (state is CoursesLoaded) {
                      print("courses from bloc: ${state.courses}");
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: state.courses.map((course) {
                              return InkWell(
                                onTap: () {
                                  context.push(AppRoutes.course_details_screen);
                                },
                                child: CourseCardVertical(
                                  //Todo ::Handel nullable
                                  title: course.title,
                                  imagePath: course.image,
                                  rating: 4.3,
                                  totalHours: 12,
                                  width: 256,
                                  description: course.description,
                                  instructorName: course.instructorName,
                                  lessonsCount: 12,
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
                SizedBox(height: 40.h),
                FeatureCard(
                  description: context.tr('test_your_knowledge'),
                  path: "assets/icons/InteractiveQuizzes.png",
                  title: context.tr('interactive_quizzes'),
                ),
                SizedBox(height: 20.h),
                FeatureCard(
                  description: context.tr('test_your_knowledge'),
                  path: "assets/icons/DiscussionBoards.png",
                  title: context.tr('discussion_boards'),
                ),
                SizedBox(height: 20.h),
                FeatureCard(
                  description: context.tr('test_your_knowledge'),
                  path: "assets/icons/DownloadableResources.png",
                  title: context.tr('downloadable_resources'),
                ),
                SizedBox(height: 40.h),
                CustomOutlinedButton(
                  text: context.tr('join_us_today'),
                  textStyle: context.textTheme.labelSmall!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    backgroundColor: context.colorScheme.primary.withValues(
                      alpha: 0.05,
                    ),
                    side: BorderSide(
                      width: 1,
                      color: context.colorScheme.primary.withValues(
                        alpha: 0.05,
                      ),
                    ),
                  ),
                  width: 150,
                  height: 40,
                  onTap: () {},
                ),
                SizedBox(height: 35.h),
                Text(
                  context.tr('ready_to_start_journey'),
                  style: context.textTheme.displayMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 35.h),
                Text(
                  context.tr('join_10k_learners'),
                  style: context.textTheme.labelMedium!.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 35.h),
                CustomPrimaryButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  textStyle: TextStyle(color: context.colorScheme.onSurface),

                  text: context.tr('create_free_account'),
                  //Todo: GO TO REGISTER SCREEN
                  onTap: () {
                    context.push(AppRoutes.registerScreen);
                  },
                ),
                SizedBox(height: 15.h),
                Text(
                  context.tr('no_credit_card_required'),
                  style: context.textTheme.labelSmall!.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
          Divider(color: context.colorScheme.onSurface.withValues(alpha: 0.1)),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.06,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.facebook,
                        size: 15.w,
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  InkWell(
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.06,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.alternate_email,
                        size: 15.w,
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                context.tr('all_rights_reserved'),
                style: context.textTheme.labelSmall!.copyWith(
                  fontSize: 10.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
