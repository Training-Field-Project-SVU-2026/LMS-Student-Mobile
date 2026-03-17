import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomCategoryItem extends StatefulWidget {
  const CustomCategoryItem({super.key});

  @override
  State<CustomCategoryItem> createState() => _CustomCategoryItemState();
}

class _CustomCategoryItemState extends State<CustomCategoryItem> {
  List<String> categories = [
    "All",
    "Flutter",
    "Frontend",
    "Backend",
    "Full Stack",
    "Design",
    "Marketing",
  ];
  int selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          return Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 5.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
              child: Container(
                width: 60.w,
                height: 37.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: index == selectedCategoryIndex
                      ? context.colorScheme.primary
                      : context.colorScheme.onPrimary,
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      fontSize: context.textTheme.labelSmall!.fontSize,
                      color: index == selectedCategoryIndex
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.primary.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
