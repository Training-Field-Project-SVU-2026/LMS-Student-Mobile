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
  final int? totalHours;
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
    this.totalHours,
    this.backgroundColor,
    this.width,
    this.lessonsCount, 
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w ?? 200.w, 
      margin: EdgeInsets.only(right: 16.w), 
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],)
        ,

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           CustomImage(
              imagePath: imagePath,
              aspectRatio: 16 / 10,
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  title
                  Text(
                    title,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
        
                  // description
                  if (description != null && description!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      description!,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.4,
                        ),
                      ), // استخدمت هنا خط تاني غير التايتل عشان اصغر واهدي مش يكونوا شبه بعض
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
        
                  // instructor name
                  if (instructorName != null) ...[
                    SizedBox(height: 10.h),
                    Text(
                      instructorName!,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
        
                  SizedBox(height: 12.h),
        
                  // rating and total hours and lessons count
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      spacing: 8.w,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // rating
                       if (rating != null) Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18.w),
                            SizedBox(width: 4.w),
                            Text(
                              '$rating',
                              style: context.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        // total hours
                        if (totalHours != null)
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: context.colorScheme.onSurfaceVariant,
                                size: 14.w,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${totalHours!} h',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
        
                        // lessons count
                        if (lessonsCount != null)
                          Row(
                            children: [
                              Icon(
                                Icons.circle_rounded,
                                color: context.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.6),
                                size: 5.w,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '$lessonsCount lessons',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.6),
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
          ],
        ),
      ),
    );
  }
}
