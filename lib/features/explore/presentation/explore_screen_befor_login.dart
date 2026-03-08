import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/explore/widget/custom_category_item.dart';
import 'package:lms_student/features/explore/widget/custom_dropdown_list.dart';
import 'package:lms_student/features/explore/widget/custom_feature_button.dart';
import 'package:lms_student/features/explore/widget/feature_model.dart';
import 'package:lms_student/features/widgets/course_card_vertical.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';

class ExploreScreenBeforLogin extends StatefulWidget {
  const ExploreScreenBeforLogin({super.key});

  @override
  State<ExploreScreenBeforLogin> createState() =>
      _ExploreScreenBeforLoginState();
}

class _ExploreScreenBeforLoginState extends State<ExploreScreenBeforLogin> {
  List<FeatureModel> features = [
    FeatureModel(color: Color(0xffDBEAFE), icon: Icons.code, text: "Dev"),
    FeatureModel(color: Color(0xffF3E8FF), icon: Icons.palette, text: "Design"),
    FeatureModel(color: Color(0xffFFEDD5), icon: Icons.analytics, text: "Data"),
    FeatureModel(
      color: Color(0xffD1FAE5),
      icon: Icons.trending_up,
      text: "Business",
    ),
    FeatureModel(color: Color(0xffDBEAFE), icon: Icons.code, text: "Dev"),
    FeatureModel(color: Color(0xffF3E8FF), icon: Icons.palette, text: "Design"),
    FeatureModel(color: Color(0xffFFEDD5), icon: Icons.analytics, text: "Data"),
    FeatureModel(
      color: Color(0xffD1FAE5),
      icon: Icons.trending_up,
      text: "Business",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 9.w, right: 15.w, top: 18.h),
        child: ListView(
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                CustomTextFormField(
                  width: 315,
                  prefixIcon: Icon(
                    Icons.search,
                    color: context.colorScheme.onSurface,
                  ),
                  hintText: "Search courses, instructors...",
                ),

                const Spacer(),
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.onPrimary,
                  ),
                  child: Icon(
                    Icons.filter_hdr_rounded,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CustomCategoryItem(),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore",
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                CustomDropdownList(),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Browse Categories",
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                Text(
                  "See All",
                  style: context.textTheme.labelMedium!.copyWith(
                    fontSize: 14.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  features.length,
                  (index) => FeatureButton(model: features[index]),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending",
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                Text(
                  "See All",
                  style: context.textTheme.labelMedium!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 13.h),
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
            SizedBox(height: 13.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Releases",
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                Text(
                  "See All",
                  style: context.textTheme.labelMedium!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
