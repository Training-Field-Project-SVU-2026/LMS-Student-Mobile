// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lms_student/core/extensions/context_extensions.dart';

// class CustomDropdownList extends StatefulWidget {
//   const CustomDropdownList({super.key});

//   @override
//   State<CustomDropdownList> createState() => _CustomDropdownList();
// }

// class _CustomDropdownList extends State<CustomDropdownList> {
//   String selectedValue = "Top Rated";

//   List<String> items = [
//     "Top Rated",
//     "Most Popular",
//     "Newest",
//     "Price Low",
//     "Price High",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 155.w,
//       height: 30.h,
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: context.colorScheme.secondary, // اللون الأخضر
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           Text(
//             "Sort:",
//             style: context.textTheme.bodyMedium!.copyWith(
//               color: context.colorScheme.onSurface.withValues(alpha: 0.5),
//             ),
//           ),
//           DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               value: selectedValue,
//               isDense: false,
//               icon: Icon(Icons.keyboard_arrow_down, size: 15.sp),
//               items: items.map((item) {
//                 return DropdownMenuItem(
//                   value: item,
//                   child: Text(
//                     item,
//                     style: context.textTheme.bodyMedium!.copyWith(
//                       color: context.colorScheme.onSurface,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedValue = value!;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class CustomDropdownList extends StatefulWidget {
  const CustomDropdownList({super.key});

  @override
  State<CustomDropdownList> createState() => _CustomDropdownListState();
}

class _CustomDropdownListState extends State<CustomDropdownList> {
  String selectedValue = "Top Rated";

  List<String> items = [
    "Top Rated",
    "Most Popular",
    "Newest",
    "Price Low",
    "Price High",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 30.h,
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sort:",
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),

          SizedBox(width: 5.w),

          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down, size: 16.sp),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
