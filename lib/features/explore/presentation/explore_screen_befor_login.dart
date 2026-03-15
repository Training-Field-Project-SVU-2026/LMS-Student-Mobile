import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/explore/presentation/bloc/packages_model_bloc.dart';
import 'package:lms_student/features/explore/widget/custom_category.dart';
import 'package:lms_student/features/explore/widget/custom_category_item.dart';
import 'package:lms_student/features/explore/widget/custom_dropdown_list.dart';
import 'package:lms_student/features/home/presentation/bloc/home_bloc.dart';
import 'package:lms_student/features/widgets/course_card_vertical.dart';
import 'package:lms_student/features/widgets/custom_text_form_field.dart';
import 'package:lms_student/core/localization/app_localizations.dart';

class ExploreScreenBeforLogin extends StatefulWidget {
  const ExploreScreenBeforLogin({super.key});

  @override
  State<ExploreScreenBeforLogin> createState() =>
      _ExploreScreenBeforLoginState();
}

class _ExploreScreenBeforLoginState extends State<ExploreScreenBeforLogin> {
  @override
  void initState() {
    super.initState();
    context.read<PackageBloc>().add(Getallpackage());
    context.read<HomeBloc>().add(GetCoursesEvent());
  }

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
                  hintText: context.tr('search_courses_instructors'),
                ),

                const Spacer(),
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.onPrimary,
                  ),
                  child: Icon(Icons.tune, color: context.colorScheme.primary),
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
                  context.tr('explore'),
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                CustomDropdownList(),
              ],
            ),
            SizedBox(height: 10.h),

            SizedBox(height: 13.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_outlined,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      context.tr('learning_tracks'),
                      style: context.textTheme.headlineLarge!.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Text(
                  context.tr('see_all'),
                  style: context.textTheme.titleSmall!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 320.h,
              child: BlocBuilder<PackageBloc, PackageState>(
                builder: (context, state) {
                  if (state is Packagesloading) {
                    return Container(
                      height: 280.h,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is Packageserror) {
                    return Container(
                      height: 280.h,
                      child: Center(child: Text('Error : ${state.message}')),
                    );
                  }
                  if (state is Packagesloaded) {
                    print("courses from bloc: ${state.package}");
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.package.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 8.w,
                          ),
                          child: IntrinsicHeight(
                            child: CustomCategory(
                              title: state.package[index].title,
                              description: state.package[index].price
                                  .toString(),
                              courseslessons: 12,
                              coursehours: 18,
                              category: state.package[index].categories,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_outlined,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      context.tr('many_courses'),
                      style: context.textTheme.headlineLarge!.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Text(
                  context.tr('see_all'),
                  style: context.textTheme.titleSmall!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
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

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.courses.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) {
                      final course = state.courses[index];

                      return IntrinsicHeight(
                        child: InkWell(
                          onTap: () {
                            context.push(AppRoutes.courseDetailsScreen);
                          },
                          child: CourseCardVertical(
                            title: course.title,
                            imagePath: course.image,
                            rating: 3.4,
                            totalHours: 12,
                            width: 256,
                            description: course.description,
                            instructorName: course.instructorName,
                            lessonsCount: 12,
                          ),
                        ),
                      );
                    },
                  );
                }

                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}




// return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 10,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 16.h,
//                           horizontal: 8.w,
//                         ),
//                         child: IntrinsicHeight(
//                           child: CustomCategory(
//                             title: context.tr('full_stack_web_development'),
//                             description: context.tr('master_the_art'),
//                             courseslessons: 12,
//                             coursehours: 18,
//                           ),
//                         ),
//                       );
//                     },
//                   );