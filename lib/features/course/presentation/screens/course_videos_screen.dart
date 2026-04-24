import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/course/presentation/screens/widget/custom_video_player.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/course/data/models/video_model.dart';
import 'package:lms_student/features/course/presentation/screens/widget/custom_course_videos_item.dart';

class CourseVideosScreen extends StatefulWidget {
  const CourseVideosScreen({super.key});

  @override
  State<CourseVideosScreen> createState() => _CourseVideosScreenState();
}

class _CourseVideosScreenState extends State<CourseVideosScreen> {
  int currentIndex = 0;

  final List<VideoModel> videos = [
    VideoModel(
      slug: "vid-1",
      title: "Introduction to Advanced Patterns",
      videoUrl: "https://youtu.be/oBdP4ZmlKRU?si=m-GIW9Zexrplm_EC",
      videoUpload: "",
      order: 1,
      course: "flutter",
      duration: "12:00",
      isCompleted: true,
    ),
    VideoModel(
      slug: "vid-2",
      title: "Advanced React Patterns: HOCs",
      videoUrl: "https://youtu.be/I0RhkhZf-XA?si=B-P3eDHOnsA26eYv",
      videoUpload: "",
      order: 2,
      course: "flutter",
      duration: "24:30",
      isPlaying: true,
    ),
    VideoModel(
      slug: "vid-3",
      title: "Render Props vs HOCs",
      videoUrl: "https://www.youtube.com/live/K1yQZ1zVkVU?si=64gWF4i4EkZPj36t",
      videoUpload: "",
      order: 3,
      course: "flutter",
      duration: "18:15",
      isCompleted: true,
    ),
  ];

  void playVideo(int index) {
    setState(() {
      // تحديث حالة التشغيل لكل الفيديوهات
      for (var i = 0; i < videos.length; i++) {
        videos[i].isPlaying = (i == index);
      }
      currentIndex = index;
    });
  }

  void nextVideo() {
    if (currentIndex < videos.length - 1) {
      playVideo(currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentVideo = videos[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Course Videos")),
      body: Column(
        children: [
          /// 🎬 الفيديو
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CustomVideoPlayer(url: currentVideo.videoUrl),
          ),

          SizedBox(height: 10.h),

          /// 📄 العنوان + زرار
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentVideo.title,
                  style: context.textTheme.displayMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 16.h),

                Center(
                  child: CustomPrimaryButton(
                    text: "Next Lesson",
                    suffixIcon: Icon(Icons.arrow_forward),
                    onTap: nextVideo,
                  ),
                ),
              ],
            ),
          ),

          /// 📚 ليست الفيديوهات
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return CustomCourseVideosItem(
                  video: videos[index],
                  onTap: () => playVideo(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
