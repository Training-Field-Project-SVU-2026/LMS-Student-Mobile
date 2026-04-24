import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String url;

  const CustomVideoPlayer({super.key, required this.url});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late YoutubePlayerController _controller;

  String? _extractVideoId(String url) {
    String? id = YoutubePlayer.convertUrlToId(url);
    if (id != null) return id;

    try {
      Uri uri = Uri.parse(url);
      if (uri.pathSegments.contains('live')) {
        return uri.pathSegments.last;
      }
    } catch (_) {}
    return null;
  }

  @override
  void initState() {
    super.initState();
    final id = _extractVideoId(widget.url) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: widget.url.toLowerCase().contains('live'),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      final newId = _extractVideoId(widget.url);
      if (newId != null) {
        _controller.load(newId);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blue,
      progressColors: const ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
      ),
    );
  }
}
