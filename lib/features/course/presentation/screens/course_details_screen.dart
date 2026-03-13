// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/course/widget/custom_img.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({Key? key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: SizedBox(),
        centerTitle: true,
        title: Text(context.tr('course_details')),
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
                CustomImg(
                  imgUrl:
                      "https://i.pinimg.com/736x/c9/ef/8b/c9ef8bf4a50ef8d51ecaf756ecfb7550.jpg",
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Advanced React Native Architecture",
                        style: context.textTheme.displayLarge!.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "\$49.99",
                        style: context.textTheme.displayMedium!.copyWith(
                          fontSize: 28,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      SizedBox(height: 22.h),
                      Text(
                        "About this course",
                        style: context.textTheme.displayMedium!.copyWith(
                          fontSize: 28,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "The section on CI/CD saved me weeks of troubleshooting. Extremely practical content.",
                        style: context.textTheme.titleLarge!.copyWith(
                          // fontSize: 28,
                          color: context.colorScheme.onSurface,
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
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.2,
                                ),
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
                                  imgUrl:
                                      "https://i.pinimg.com/736x/c9/ef/8b/c9ef8bf4a50ef8d51ecaf756ecfb7550.jpg",
                                ),
                                SizedBox(width: 16.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Taha",
                                      style: context.textTheme.displayMedium!
                                          .copyWith(
                                            color: context.colorScheme.primary,
                                          ),
                                    ),
                                    Text(
                                      "Lead Systems Architect, 12y Exp.",
                                      style: context.textTheme.labelLarge!
                                          .copyWith(
                                            color: context.colorScheme.onSurface
                                                .withValues(alpha: 0.3),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            "The section on CI/CD saved me weeks of troubleshooting. Extremely practical content.",
                            style: context.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
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
              text: "Enroll Now",
              textStyle: context.textTheme.labelLarge!.copyWith(
                fontSize: 16.sp,
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
 // // Features - Explore
  // sl.registerLazySingleton<ExploreRepositoryImp>(
  //   () => ExploreRepositoryImp(apiConsumer: sl()),
  // );

  // // سجل الـ ExploreRepository أيضاً إذا احتاجته أجزاء أخرى من التطبيق
  // sl.registerLazySingleton<ExploreRepository>(
  //   () => sl<ExploreRepositoryImp>(), // استخدام نفس الـ instance
  // );

  // // ثم سجل الـ bloc
  // sl.registerFactory(
  //   () => PackageBloc(
  //     exploreRepositoryImp: sl<ExploreRepositoryImp>(),
  //     exploreRepository: sl<ExploreRepositoryImp>(),
  //   ),
  // );

