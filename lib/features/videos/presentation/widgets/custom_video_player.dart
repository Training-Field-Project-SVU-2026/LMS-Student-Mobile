import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:lms_student/features/videos/data/models/video_model.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_bloc.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_event.dart';
import 'package:lms_student/features/videos/presentation/bloc/videos_state.dart';
import 'package:lms_student/features/videos/presentation/widgets/video_player/video_source_helper.dart';
import 'package:lms_student/features/videos/presentation/widgets/video_player/youtube_player_view.dart';
import 'package:lms_student/features/videos/presentation/widgets/video_player/server_video_player_view.dart';
import 'package:lms_student/features/videos/presentation/widgets/video_player/player_overlay.dart';

class CustomVideoPlayer extends StatefulWidget {
  final VideoModel video;
  final VoidCallback onVideoEnded;

  const CustomVideoPlayer({super.key, required this.video, required this.onVideoEnded});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _videoController;
  bool _isYoutube = false;
  bool _isCompletionTriggered = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.videoUrl != widget.video.videoUrl ||
        oldWidget.video.videoUpload != widget.video.videoUpload) {
      _initializePlayer();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _youtubeController?.dispose();
    _youtubeController = null;
    _videoController?.dispose();
    _videoController = null;
  }

  void _initializePlayer() {
    _disposeControllers();
    _isCompletionTriggered = false;
    _setLoading(true);

    final youtubeUrl = widget.video.videoUrl;
    final uploadUrl = widget.video.videoUpload;
    log("youtubeUrl: $youtubeUrl uploadUrl: $uploadUrl");

    if (youtubeUrl != null && youtubeUrl.isNotEmpty) {
      _initYoutube(youtubeUrl);
    } else if (uploadUrl != null && uploadUrl.isNotEmpty) {
      _initServerVideo(uploadUrl);
    } else {
      _setError(context.tr('no_video_content'));
      _setLoading(false);
    }
  }

  void _youtubeListener() {
    if (!mounted || _youtubeController == null) return;

    if (_youtubeController!.value.hasError) {
      _setError("YouTube Error: ${_youtubeController!.value.errorCode}");
    }

    final position = _youtubeController!.value.position;
    final duration = _youtubeController!.metadata.duration;

    if (duration.inSeconds > 0 && !_isCompletionTriggered) {
      final progress = position.inMilliseconds / duration.inMilliseconds;
      if (progress >= 0.95) {
        _isCompletionTriggered = true;
        widget.onVideoEnded();
      }
    }
  }

  void _initYoutube(String url) {
    _isYoutube = true;
    final id = VideoSourceHelper.extractYoutubeId(url);
    if (id == null) {
      _setError(context.tr('invalid_youtube_url'));
      return;
    }

    _youtubeController =
        YoutubePlayerController(
          initialVideoId: id,
          flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
        )..addListener(_youtubeListener);
    _setLoading(false);
  }

  void _serverVideoListener() {
    if (!mounted || _videoController == null) return;

    if (_videoController!.value.hasError) {
      _setError(_videoController!.value.errorDescription ?? 'Video Error');
    }

    final position = _videoController!.value.position;
    final duration = _videoController!.value.duration;

    if (duration.inSeconds > 0 && !_isCompletionTriggered) {
      final progress = position.inMilliseconds / duration.inMilliseconds;
      if (progress >= 0.95) {
        _isCompletionTriggered = true;
        widget.onVideoEnded();
      }
    }
  }

  void _initServerVideo(String path) {
    _isYoutube = false;
    _videoController = VideoPlayerController.network(
      VideoSourceHelper.getFullServerUrl(path),
    );

    _videoController!
        .initialize()
        .then((_) {
          if (!mounted) return;
          _videoController!.play();
          _setLoading(false);
        })
        .onError((error, stackTrace) {
          if (!mounted) return;
          _setError(context.tr('failed_to_load_video') + error.toString());
        })
        .catchError((error) {
          if (!mounted) return;
          _setError(context.tr('failed_to_load_video') + error.toString());
        });

    _videoController!.addListener(_serverVideoListener);
  }

  void _setLoading(bool loading) => context.read<VideosBloc>().add(
    VideoPlayerLoadingEvent(isLoading: loading),
  );
  void _setError(String msg) =>
      context.read<VideosBloc>().add(VideoPlayerErrorEvent(message: msg));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosState>(
      builder: (context, state) {
        final error = (state is VideosLoaded) ? state.playerError : null;
        final isLoading = (state is VideosLoaded)
            ? state.isVideoLoading
            : false;

        return Container(
          color: context.colorScheme.onSurface,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_isYoutube && _youtubeController != null)
                YoutubePlayerView(
                  key: ValueKey(widget.video.videoUrl),
                  controller: _youtubeController!,
                  onReady: () => _setLoading(false),
                  onVideoEnded: widget.onVideoEnded,
                )
              else if (!_isYoutube && _videoController != null)
                ServerVideoPlayerView(
                  key: ValueKey(widget.video.videoUpload),
                  controller: _videoController!,
                )
              else if (!isLoading && (error == null || error.isEmpty))
                PlayerOverlay(isLoading: true, onRetry: _dummyRetry),
              PlayerOverlay(
                isLoading: isLoading,
                error: error,
                onRetry: _initializePlayer,
              ),
            ],
          ),
        );
      },
    );
  }

  static void _dummyRetry() {}
}
