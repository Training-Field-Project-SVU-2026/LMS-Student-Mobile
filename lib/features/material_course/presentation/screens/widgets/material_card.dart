import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/material_course/domain/entity/course_materials_ui_model.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';

class MaterialCard extends StatelessWidget {
  final CourseMaterialItemUIModel material;

  const MaterialCard({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    String? fullFileUrl;
    if (material.file != null) {
      if (material.file!.startsWith('http')) {
        fullFileUrl = material.file;
      } else {
        fullFileUrl = EndPoint.mediaBaseUrl + material.file!;
      }
    }

    void handleView() {
      if (fullFileUrl != null) {
        context.push(
          AppRoutes.pdfViewerScreen,
          extra: {'url': fullFileUrl, 'title': material.materialName},
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('File URL is missing')));
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: handleView,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: context.colorScheme.error.withValues(
                          alpha: 0.05,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.picture_as_pdf_outlined,
                        color: context.colorScheme.error,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            material.materialName,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                Icons.save_outlined,
                                size: 14.sp,
                                color: context.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.6),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                material.fileSize ?? '0 MB',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 14.sp,
                                color: context.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.6),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                material.createdAt ?? '',
                                style: context.textTheme.labelMedium?.copyWith(
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
                SizedBox(height: 16.h),
                CustomPrimaryButton(
                  text: context.tr('view'),
                  onTap: handleView,
                  width: double.infinity,
                  height: 44.h,
                  color: context.colorScheme.secondary,
                  textStyle: context.textTheme.labelLarge?.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
