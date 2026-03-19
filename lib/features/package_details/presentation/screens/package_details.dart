import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/features/explore/presentation/screens/widget/custom_head_of_packe_detals.dart';
import 'package:lms_student/features/explore/presentation/screens/widget/custom_package_caregory.dart';
import 'package:lms_student/features/explore/presentation/screens/widget/custon_instractor_information.dart';
import 'package:lms_student/features/package_details/presentation/bloc/package_details_bloc.dart';
import 'package:lms_student/features/widgets/course_card_horizontal.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class PackageDetails extends StatefulWidget {
  final String slug;
  const PackageDetails({super.key, required this.slug});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PackageDetailsBloc>().add(
          GetpackagesEventBySlug(slug: widget.slug),
        );
      }
    });
  }

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
      body: BlocBuilder<PackageDetailsBloc, PackageDetailsState>(
        builder: (context, state) {
          if (state is PackageDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PackageDetailsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PackageDetailsBloc>().add(
                        GetpackagesEventBySlug(slug: widget.slug),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is PackageDetailsLoaded) {
            final package = state.packagesModel;

            return Column(
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
                              CustomPackageCaregory(
                                category: package.categories,
                              ),
                              SizedBox(height: 5.h),
                              CustomHeadOfPackeDetals(
                                courseName: package.title,
                                lesson: package.coursesCount,
                              ),
                              SizedBox(height: 15.h),
                              CustonInstractorInformation(
                                insName: package.instructorName,
                              ),
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
                        package.description,
                        style: context.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
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
                        itemCount: package.courses?.length ?? 0,
                        itemBuilder: (context, index) {
                          final course = package.courses?[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.r),
                            child: InkWell(
                              onTap: () {
                                context.push(
                                  AppRoutes.courseDetailsScreen,
                                  extra: course.slug,
                                );
                              },
                              child: IntrinsicHeight(
                                child: CourseCardHorizontal(
                                  title: course!.title,
                                  instructorName: course.instructorName,
                                  rating: course.avgRating,
                                  //! TODO add Price
                                ),
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
                      Text(
                        "\$${package.price}",
                        style: context.textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      CustomPrimaryButton(
                        text: context.tr('enroll_now'),
                        onTap: () {},
                        width: 240,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
