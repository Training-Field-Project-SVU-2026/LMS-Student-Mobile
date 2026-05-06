import 'package:dartz/dartz.dart';
import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';
import 'package:lms_student/features/videos/data/models/response_videos_model.dart';
import 'package:lms_student/features/videos/domain/repositories/videos_repository.dart';

class VideosRepositoryImpl implements VideosRepository {
  final ApiConsumer apiConsumer;

  VideosRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, ResponseVideosModel>> getCourseVideos(String slug) async {
    return await apiConsumer.get<ResponseVideosModel>(
      EndPoint.courseVideos(slug),
      fromJson: (json) => ResponseVideosModel.fromJson(json),
    );
  }
}
