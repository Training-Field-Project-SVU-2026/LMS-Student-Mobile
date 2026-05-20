import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';

class YoutubePlayerView extends StatefulWidget {
  final YoutubePlayerController controller;
  final VoidCallback onReady;
  final VoidCallback onVideoEnded;

  const YoutubePlayerView({
    super.key,
    required this.controller,
    required this.onReady,
    required this.onVideoEnded,
  });

  @override
  State<YoutubePlayerView> createState() => _YoutubePlayerViewState();
}

class _YoutubePlayerViewState extends State<YoutubePlayerView> {
  bool _isFullScreen = false;

  Future<void> _enterFullScreen(BuildContext context) async {
    setState(() {
      _isFullScreen = true;
    });

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    if (!context.mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenYoutubePlayerPage(
          controller: widget.controller,
          onVideoEnded: widget.onVideoEnded,
        ),
      ),
    );

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (mounted) {
      setState(() {
        _isFullScreen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFullScreen) {
      return Container(color: Colors.black);
    }

    return YoutubePlayer(
      controller: widget.controller,
      showVideoProgressIndicator: false,
      progressIndicatorColor: context.colorScheme.primary,
      onReady: widget.onReady,
      onEnded: (_) => widget.onVideoEnded(),
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
            final currentPosition = widget.controller.value.position;
            widget.controller.seekTo(
              currentPosition - const Duration(seconds: 10),
            );
          },
        ),
        const SizedBox(width: 8.0),
        IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.forward_10, color: Colors.white, size: 20),
          onPressed: () {
            final currentPosition = widget.controller.value.position;
            widget.controller.seekTo(
              currentPosition + const Duration(seconds: 10),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.fullscreen, color: Colors.white),
          onPressed: () => _enterFullScreen(context),
        ),
      ],
    );
  }
}

class FullScreenYoutubePlayerPage extends StatefulWidget {
  final YoutubePlayerController controller;
  final VoidCallback onVideoEnded;

  const FullScreenYoutubePlayerPage({
    super.key,
    required this.controller,
    required this.onVideoEnded,
  });

  @override
  State<FullScreenYoutubePlayerPage> createState() =>
      _FullScreenYoutubePlayerPageState();
}

class _FullScreenYoutubePlayerPageState
    extends State<FullScreenYoutubePlayerPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          controller: widget.controller,
          showVideoProgressIndicator: false,
          onEnded: (_) => widget.onVideoEnded(),
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
                final currentPosition = widget.controller.value.position;
                widget.controller.seekTo(
                  currentPosition - const Duration(seconds: 10),
                );
              },
            ),
            const SizedBox(width: 8.0),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.forward_10, color: Colors.white, size: 20),
              onPressed: () {
                final currentPosition = widget.controller.value.position;
                widget.controller.seekTo(
                  currentPosition + const Duration(seconds: 10),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
