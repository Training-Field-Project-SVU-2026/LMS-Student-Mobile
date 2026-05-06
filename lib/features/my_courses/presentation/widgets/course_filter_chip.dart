import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/my_courses/presentation/bloc/my_courses_bloc.dart';
import 'package:lms_student/features/my_courses/presentation/bloc/my_courses_event.dart';

class CourseFilterChip extends StatelessWidget {
  final String label;
  final String statusKey;
  final bool isSelected;

  const CourseFilterChip({
    super.key,
    required this.label,
    required this.statusKey,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MyCoursesBloc>().add(FilterMyCoursesEvent(statusKey));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
