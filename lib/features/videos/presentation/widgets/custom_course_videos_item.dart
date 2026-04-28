import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          color: video.isPlaying ? const Color(0xFFE3F2FD) : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: video.isPlaying
                  ? Colors.blue.shade900
                  : Colors.transparent,
              width: 4.w,
            ),
            bottom: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _buildLeadingIcon(),

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
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: video.isPlaying
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: video.isLocked
                          ? Colors.grey
                          : (video.isPlaying
                                ? Colors.blue.shade900
                                : Colors.black87),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${video.duration} ${video.isCompleted ? '• Completed' : (video.isPlaying ? '• In Progress' : '')}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            if (video.isPlaying)
              Icon(Icons.equalizer, color: Colors.blue.shade900, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    if (video.isLocked) {
      return Icon(Icons.lock_outline, color: Colors.grey, size: 28.sp);
    }
    if (video.isCompleted) {
      return Icon(
        Icons.check_circle,
        color: Colors.green.shade300,
        size: 28.sp,
      );
    }
    if (video.isPlaying) {
      return Icon(
        Icons.play_circle_fill,
        color: Colors.blue.shade900,
        size: 32.sp,
      );
    }
    return Icon(
      Icons.check_circle_outline,
      color: Colors.grey.shade400,
      size: 28.sp,
    );
  }
}
