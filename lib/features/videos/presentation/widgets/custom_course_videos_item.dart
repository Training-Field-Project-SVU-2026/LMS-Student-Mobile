import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/videos/data/models/video_model.dart';

class CustomCourseVideosItem extends StatelessWidget {
  final VideoModel video;
  final VoidCallback onTap;

  const CustomCourseVideosItem({
    super.key,
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: video.isLocked ? null : onTap,
      child: Container(
        height: 85.h,
        decoration: BoxDecoration(
          color: video.isPlaying
              ? context.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: video.isPlaying
                  ? context.colorScheme.primary
                  : Colors.transparent,
              width: 4.w,
            ),
            bottom: BorderSide(
              color: context.extraColors.divider ?? context.colorScheme.outline,
              width: 1,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _buildLeadingIcon(context),

            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight:
                          video.isPlaying ? FontWeight.bold : FontWeight.w500,
                      color: video.isLocked
                          ? context.extraColors.textTertiary
                          : (video.isPlaying
                              ? context.colorScheme.primary
                              : context.colorScheme.onSurface),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${video.duration} ${video.isCompleted ? '• Completed' : (video.isPlaying ? '• In Progress' : '')}",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            if (video.isPlaying)
              Icon(
                Icons.equalizer,
                color: context.colorScheme.primary,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    if (video.isLocked) {
      return Icon(
        Icons.lock_outline,
        color: context.extraColors.textTertiary,
        size: 28.sp,
      );
    }
    if (video.isCompleted) {
      return Icon(
        Icons.check_circle,
        color: context.colorScheme.secondary,
        size: 28.sp,
      );
    }
    if (video.isPlaying) {
      return Icon(
        Icons.play_circle_fill,
        color: context.colorScheme.primary,
        size: 32.sp,
      );
    }
    return Icon(
      Icons.check_circle_outline,
      color: context.extraColors.textTertiary?.withOpacity(0.5),
      size: 28.sp,
    );
  }
}
