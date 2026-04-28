import 'package:dartz/dartz.dart';
import 'package:lms_student/features/videos/data/models/response_videos_model.dart';

abstract class VideosRepository {
  Future<Either<String, ResponseVideosModel>> getCourseVideos(String slug);
}
