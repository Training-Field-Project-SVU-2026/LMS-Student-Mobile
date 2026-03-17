// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class CustomCategory extends StatefulWidget {
  final String title;
  final String description;
  final int courseslessons;
  final int coursehours;
  final List<String> category;
  const CustomCategory({
    super.key,
    required this.title,
    required this.description,
    required this.courseslessons,
    required this.coursehours,
    required this.category,
  });

  @override
  State<CustomCategory> createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      width: 332.w,
      height: 262.h,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 18.r,
            offset: Offset(4, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            maxLines: 2,
            style: context.textTheme.labelLarge!.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            widget.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall!.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          Spacer(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.category.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    width: 65.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      widget.category[index],
                      style: context.textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
            ),
          ),
          Spacer(),
          Divider(
            color: context.colorScheme.onSurface.withValues(alpha: 0.3),
            height: 2.w,
          ),
          Spacer(),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.menu_book_sharp,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${widget.courseslessons} Courses",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 5.w),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${widget.coursehours} Hours",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              CustomPrimaryButton(
                text: "Join Now",
                width: 86,
                height: 33,
                textStyle: context.textTheme.labelLarge!.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
