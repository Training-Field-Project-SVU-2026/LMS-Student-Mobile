import 'package:equatable/equatable.dart';
import 'package:lms_student/features/videos/data/models/video_model.dart';

abstract class VideosState extends Equatable {
  const VideosState();
  
  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosLoaded extends VideosState {
  final List<VideoModel> videos;

  const VideosLoaded({required this.videos});

  @override
  List<Object> get props => [videos];
}

class VideosError extends VideosState {
  final String message;

  const VideosError({required this.message});

  @override
  List<Object> get props => [message];
}
