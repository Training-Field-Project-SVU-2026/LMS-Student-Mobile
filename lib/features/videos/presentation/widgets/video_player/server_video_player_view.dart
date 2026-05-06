import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class ServerVideoPlayerView extends StatefulWidget {
  final VideoPlayerController controller;

  const ServerVideoPlayerView({super.key, required this.controller});

  @override
  State<ServerVideoPlayerView> createState() => _ServerVideoPlayerViewState();
}

class _ServerVideoPlayerViewState extends State<ServerVideoPlayerView> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_chewieController == null) {
      _initChewie();
    }
  }

  void _initChewie() {
    _chewieController = ChewieController(
      videoPlayerController: widget.controller,
      aspectRatio: widget.controller.value.aspectRatio,
      autoPlay: true,
      looping: false,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: context.colorScheme.primary,
        handleColor: context.colorScheme.primary,
        bufferedColor: context.colorScheme.surface.withOpacity(0.5),
        backgroundColor: context.colorScheme.surface.withOpacity(0.2),
      ),
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null) return const SizedBox.shrink();

    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: Chewie(controller: _chewieController!),
    );
  }
}
