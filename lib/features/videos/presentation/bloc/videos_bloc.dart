import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/videos/data/models/response_videos_model.dart';
import 'package:lms_student/features/videos/domain/repositories/videos_repository.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_event.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideosRepository videosRepository;

  VideosBloc({required this.videosRepository}) : super(VideosInitial()) {
    on<GetCourseVideos>(_onGetCourseVideos);
    on<PlayVideoEvent>(_onPlayVideo);
  }

  Future<void> _onGetCourseVideos(
    GetCourseVideos event,
    Emitter<VideosState> emit,
  ) async {
    emit(VideosLoading());

    final result = await videosRepository.getCourseVideos(event.slug);

    result.fold(
      (error) => emit(VideosError(message: error)),
      (response) {
        final videos = response.data;
        if (videos.isNotEmpty) {
          videos[0].isPlaying = true;
        }
        emit(VideosLoaded(videos: videos));
      },
    );
  }

  void _onPlayVideo(
    PlayVideoEvent event,
    Emitter<VideosState> emit,
  ) {
    if (state is VideosLoaded) {
      final currentState = state as VideosLoaded;
      final videos = List.of(currentState.videos);
      
      for (var i = 0; i < videos.length; i++) {
        videos[i].isPlaying = (i == event.index);
      }

      // Emit a new loaded state to update the UI
      emit(VideosLoaded(videos: videos));
    }
  }
}
