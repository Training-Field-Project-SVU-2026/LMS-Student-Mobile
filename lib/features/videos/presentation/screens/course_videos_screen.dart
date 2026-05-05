import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_bloc.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_event.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_state.dart';
import 'package:lms_student/features/videos/presentation/widgets/custom_video_player.dart';
import 'package:lms_student/features/widgets/custom_primary_button.dart';
import 'package:lms_student/features/videos/data/models/video_model.dart';
import 'package:lms_student/features/videos/presentation/widgets/custom_course_videos_item.dart';

class CourseVideosScreen extends StatefulWidget {
  final String slug;

  const CourseVideosScreen({super.key, required this.slug});

  @override
  State<CourseVideosScreen> createState() => _CourseVideosScreenState();
}

class _CourseVideosScreenState extends State<CourseVideosScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<VideosBloc>().add(GetCourseVideos(slug: widget.slug));
  }

  void playVideo(int index, List<VideoModel> videos) {
    context.read<VideosBloc>().add(PlayVideoEvent(index: index));
    setState(() {
      currentIndex = index;
    });
  }

  void nextVideo(List<VideoModel> videos) {
    if (currentIndex < videos.length - 1) {
      playVideo(currentIndex + 1, videos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Course Videos")),
      body: BlocBuilder<VideosBloc, VideosState>(
        builder: (context, state) {
          if (state is VideosLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideosError) {
            return Center(child: Text(state.message));
          } else if (state is VideosLoaded) {
            final videos = state.videos;
            if (videos.isEmpty) {
              return const Center(child: Text("No videos found"));
            }

            return Column(
              children: [
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: CustomVideoPlayer(video: videos[currentIndex]),
                // ),
                SizedBox(height: 10.h),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.r,
                    vertical: 12.r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        videos[currentIndex].title,
                        style: context.textTheme.displayMedium!.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Center(
                        child: CustomPrimaryButton(
                          text: "Next Lesson",
                          suffixIcon: const Icon(Icons.arrow_forward),
                          onTap: () => nextVideo(videos),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return CustomCourseVideosItem(
                        video: videos[index],
                        onTap: () => playVideo(index, videos),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
