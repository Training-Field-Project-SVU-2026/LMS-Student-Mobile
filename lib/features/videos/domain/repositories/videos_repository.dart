import 'package:dartz/dartz.dart';
import 'package:lms_student/features/videos/data/models/response_videos_model.dart';

abstract class VideosRepository {
  Future<Either<String, ResponseVideosModel>> getCourseVideos(String slug);
  Future<Either<String, Map<String, dynamic>>> completeVideo(
    String videoSlug,
    double currentTime,
  );
}
 