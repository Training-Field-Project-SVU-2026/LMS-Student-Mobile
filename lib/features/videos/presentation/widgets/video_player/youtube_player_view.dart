import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class YoutubePlayerView extends StatelessWidget {
  final YoutubePlayerController controller;
  final VoidCallback onReady;

  const YoutubePlayerView({
    super.key,
    required this.controller,
    required this.onReady,
  });

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: context.colorScheme.primary,
        onReady: onReady,
        bottomActions: [
          const SizedBox(width: 8.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          const PlaybackSpeedButton(),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.replay_10, color: Colors.white, size: 20),
            onPressed: () {
              final currentPosition = controller.value.position;
              controller.seekTo(currentPosition - const Duration(seconds: 10));
            },
          ),
          const SizedBox(width: 8.0),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.forward_10, color: Colors.white, size: 20),
            onPressed: () {
              final currentPosition = controller.value.position;
              controller.seekTo(currentPosition + const Duration(seconds: 10));
            },
          ),
          const FullScreenButton(),
        ],
      ),
      builder: (context, player) => player,
    );
  }
}
