import 'package:equatable/equatable.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class GetCourseVideos extends VideosEvent {
  final String slug;

  const GetCourseVideos({required this.slug});

  @override
  List<Object> get props => [slug];
}

class PlayVideoEvent extends VideosEvent {
  final int index;

  const PlayVideoEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class VideoPlayerErrorEvent extends VideosEvent {
  final String message;

  const VideoPlayerErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class VideoPlayerLoadingEvent extends VideosEvent {
  final bool isLoading;

  const VideoPlayerLoadingEvent({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}
