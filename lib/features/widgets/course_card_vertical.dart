import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/widgets/custom_image.dart';

class CourseCardVertical extends StatelessWidget {
  final String title;
  final String? imagePath;
  final String? description;
  final String? instructorName;
  final double? rating;
  final double? price;
  final int? totalStudents;
  final Color? backgroundColor;
  final double? width;
  final int? lessonsCount;
  final VoidCallback? onTap;

  const CourseCardVertical({
    super.key,
    required this.title,
    this.imagePath,
    this.description,
    this.instructorName,
    this.rating,
    this.price,
    this.totalStudents,
    this.backgroundColor,
    this.width,
    this.lessonsCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w ?? 256.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.05),
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                imagePath: imagePath,
                aspectRatio: 16 / 10,
                width: double.infinity,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    //  title
                    Text(
                      title,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // description
                    if (description != null && description!.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        description!,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    // instructor name
                    if (instructorName != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        instructorName!,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    // price
                    if (price != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        '\$$price',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                    SizedBox(height: 5.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // rating
                        if (rating != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14.w),
                              SizedBox(width: 4.w),
                              Text(
                                '$rating',
                                style: context.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),

                        // total Students
                        if (totalStudents != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person,
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.8,
                                ),
                                size: 14.w,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${totalStudents!}',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurface
                                      .withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),

                        // // lessons count
                        // if (lessonsCount != null)
                        //   Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Icon(
                        //         Icons.menu_book_rounded,
                        //         color: context.colorScheme.onSurfaceVariant
                        //             .withValues(alpha: 0.8),
                        //         size: 14.w,
                        //       ),
                        //       SizedBox(width: 4.w),
                        //       Text(
                        //         '$lessonsCount lessons',
                        //         style: context.textTheme.labelSmall?.copyWith(
                        //           color: context.colorScheme.onSurfaceVariant
                        //               .withValues(alpha: 0.8),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
