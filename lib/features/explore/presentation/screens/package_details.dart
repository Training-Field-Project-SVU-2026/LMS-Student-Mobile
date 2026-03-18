import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/explore/presentation/screens/widget/custom_head_of_packe_detals.dart';
import 'package:lms_student/features/explore/presentation/screens/widget/custom_package_caregory.dart';
import 'package:lms_student/features/explore/presentation/screens/widget/custon_instractor_information.dart';
import 'package:lms_student/features/widgets/course_card_horizontal.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class PackageDetails extends StatefulWidget {
  final List<String> category;
  const PackageDetails({super.key, required this.category});
  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.tr('package_details')),
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
              padding: EdgeInsets.all(20.0.r),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.2,
                        ),
                        blurRadius: 16,
                        offset: const Offset(3, 3),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomPackageCaregory(category: widget.category),
                        SizedBox(height: 5.h),
                        const CustomHeadOfPackeDetals(),
                        SizedBox(height: 15.h),
                        CustonInstractorInformation(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  "About this package",
                  style: context.textTheme.displaySmall!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  '''A comprehensive package covering Frontend, Backend, and DevOps. Master the modern web stack with curated content designed to take you from fundamentals to professional deployment strategies.''',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Included Courses",
                  style: context.textTheme.displaySmall!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.r),
                      child: IntrinsicHeight(
                        child: CourseCardHorizontal(
                          title: "title",
                          instructorName: "taha",
                          rating: 3.4,
                          //! TODO add Price
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text("data", style: context.textTheme.bodyLarge),
                const Spacer(),
                CustomPrimaryButton(
                  text: "Enroll Now",
                  onTap: () {},
                  width: 240,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
