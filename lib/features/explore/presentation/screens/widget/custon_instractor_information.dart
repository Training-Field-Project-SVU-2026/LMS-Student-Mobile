import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/course/presentation/screens/widget/custom_img.dart';

class CustonInstractorInformation extends StatefulWidget {
  const CustonInstractorInformation({super.key});

  @override
  State<CustonInstractorInformation> createState() =>
      _CustonInstractorInformationState();
}

class _CustonInstractorInformationState
    extends State<CustonInstractorInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350.w,
          height: 86.h,
          decoration: BoxDecoration(
            color: context.colorScheme.onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              CustomImg(
                radius: 30,
                height: 56.h,
                width: 56.w,
                // imgUrl: "",
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Instructor",
                      style: context.textTheme.labelLarge!.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Taha Saber",
                      style: context.textTheme.displayMedium!.copyWith(
                        color: context.colorScheme.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
