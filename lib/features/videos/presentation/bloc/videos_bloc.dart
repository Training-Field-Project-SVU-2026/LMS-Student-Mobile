import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/videos/domain/repositories/videos_repository.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_event.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideosRepository videosRepository;

  VideosBloc({required this.videosRepository}) : super(VideosInitial()) {
    on<GetCourseVideos>(_onGetCourseVideos);
    on<PlayVideoEvent>(_onPlayVideo);
    on<VideoPlayerErrorEvent>(_onVideoPlayerError);
    on<VideoPlayerLoadingEvent>(_onVideoPlayerLoading);
    on<WatchedVideoEvent>(_onWatchedVideoEvent);
  }

  Future<void> _onGetCourseVideos(
    GetCourseVideos event,
    Emitter<VideosState> emit,
  ) async {
    emit(VideosLoading());

    final result = await videosRepository.getCourseVideos(event.slug);

    result.fold((error) => emit(VideosError(message: error)), (response) {
      final videos = response.data;
      if (videos.isNotEmpty) {
        videos[0].isPlaying = true;
      }
      emit(VideosLoaded(videos: videos));
    });
  }

  Future<void> _onWatchedVideoEvent(
    WatchedVideoEvent event,
    Emitter<VideosState> emit,
  ) async {
    if (state is VideosLoaded) {
      final currentState = state as VideosLoaded;
      final videos = List.of(currentState.videos);

      final videoIndex = videos.indexWhere((v) => v.slug == event.videoSlug);
      if (videoIndex != -1) {
        if (videos[videoIndex].isCompleted) {
          return;
        }

        videos[videoIndex].isCompleted = true;
        emit(currentState.copyWith(videos: videos));
      }

      final result = await videosRepository.completeVideo(
        event.videoSlug,
        event.duration,
      );

      await result.fold(
        (error) async {
        },
        (responseMap) async {
          final data = responseMap['data'] as Map<String, dynamic>?;
          final isCompletedOnServer = data?['is_completed'] as bool? ?? false;

          if (!isCompletedOnServer) {
            return;
          }

          final refreshResult = await videosRepository.getCourseVideos(event.courseSlug);
          refreshResult.fold(
            (error) => null,
            (response) {
              final newVideos = response.data;
              if (newVideos.isNotEmpty && videoIndex != -1) {
                for (var i = 0; i < newVideos.length; i++) {
                  if (i < currentState.videos.length) {
                    newVideos[i].isPlaying = currentState.videos[i].isPlaying;
                  }
                }
              }
              emit(currentState.copyWith(videos: newVideos));
            },
          );
        },
      );
    }
  }

  void _onPlayVideo(PlayVideoEvent event, Emitter<VideosState> emit) {
    if (state is VideosLoaded) {
      final currentState = state as VideosLoaded;
      final videos = List.of(currentState.videos);

      for (var i = 0; i < videos.length; i++) {
        videos[i].isPlaying = (i == event.index);
      }

      emit(VideosLoaded(videos: videos));
    }
  }

  void _onVideoPlayerError(
    VideoPlayerErrorEvent event,
    Emitter<VideosState> emit,
  ) {
    if (state is VideosLoaded) {
      emit(
        (state as VideosLoaded).copyWith(
          playerError: event.message,
          isVideoLoading: false,
        ),
      );
    }
  }

  void _onVideoPlayerLoading(
    VideoPlayerLoadingEvent event,
    Emitter<VideosState> emit,
  ) {
    if (state is VideosLoaded) {
      emit((state as VideosLoaded).copyWith(isVideoLoading: event.isLoading));
    }
  }
}
