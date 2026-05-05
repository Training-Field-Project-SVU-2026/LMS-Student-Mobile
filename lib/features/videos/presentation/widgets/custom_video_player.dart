// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:video_player/video_player.dart';
// import 'package:lms_student/features/videos/data/models/video_model.dart';
// import 'package:lms_student/core/services/remote/endpoints.dart';

// class CustomVideoPlayer extends StatefulWidget {
//   final VideoModel video;

//   const CustomVideoPlayer({super.key, required this.video});

//   @override
//   State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
// }

// class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
//   YoutubePlayerController? _youtubeController;
//   VideoPlayerController? _videoPlayerController;
//   bool _isYoutube = false;
//   bool _isPlayingVideo = false;

//   String? _extractVideoId(String url) {
//     String? id = YoutubePlayer.convertUrlToId(url);
//     if (id != null) return id;

//     try {
//       Uri uri = Uri.parse(url);
//       if (uri.pathSegments.contains('live')) {
//         return uri.pathSegments.last;
//       }
//     } catch (_) {}
//     return null;
//   }

//   void _initializePlayer() {
//     _disposeControllers();

//     final youtubeUrl = widget.video.videoUrl;
//     final uploadUrl = widget.video.videoUpload;

//     if (youtubeUrl != null && youtubeUrl.isNotEmpty) {
//       _isYoutube = true;
//       final id = _extractVideoId(youtubeUrl) ?? '';
//       _youtubeController = YoutubePlayerController(
//         initialVideoId: id,
//         flags: YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//           isLive: youtubeUrl.toLowerCase().contains('live'),
//         ),
//       );
//     } else if (uploadUrl != null && uploadUrl.isNotEmpty) {
//       _isYoutube = false;
//       final fullUrl = uploadUrl.startsWith('http')
//           ? uploadUrl
//           : '${EndPoint.baseUrl}$uploadUrl';
//       _videoPlayerController =
//           VideoPlayerController.networkUrl(Uri.parse(fullUrl))
//             ..initialize().then((_) {
//               if (mounted) {
//                 setState(() {
//                   _videoPlayerController!.play();
//                   _isPlayingVideo = true;
//                 });
//               }
//             });
//       _videoPlayerController!.addListener(() {
//         if (_videoPlayerController!.value.isPlaying != _isPlayingVideo) {
//           if (mounted) {
//             setState(() {
//               _isPlayingVideo = _videoPlayerController!.value.isPlaying;
//             });
//           }
//         }
//       });
//     }
//   }

//   void _disposeControllers() {
//     _youtubeController?.dispose();
//     _youtubeController = null;

//     _videoPlayerController?.dispose();
//     _videoPlayerController = null;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   @override
//   void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.video.videoUrl != widget.video.videoUrl ||
//         oldWidget.video.videoUpload != widget.video.videoUpload) {
//       _initializePlayer();
//     }
//   }

//   @override
//   void dispose() {
//     _disposeControllers();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isYoutube && _youtubeController != null) {
//       return YoutubePlayer(
//         controller: _youtubeController!,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.blue,
//         progressColors: const ProgressBarColors(
//           playedColor: Colors.blue,
//           handleColor: Colors.blueAccent,
//         ),
//       );
//     } else if (!_isYoutube && _videoPlayerController != null) {
//       return _videoPlayerController!.value.isInitialized
//           ? Stack(
//               alignment: Alignment.center,
//               children: [
//                 AspectRatio(
//                   aspectRatio: _videoPlayerController!.value.aspectRatio,
//                   child: VideoPlayer(_videoPlayerController!),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     if (_videoPlayerController!.value.isPlaying) {
//                       _videoPlayerController!.pause();
//                     } else {
//                       _videoPlayerController!.play();
//                     }
//                   },
//                   child: AnimatedOpacity(
//                     opacity: _isPlayingVideo ? 0.0 : 1.0,
//                     duration: const Duration(milliseconds: 300),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5),
//                         shape: BoxShape.circle,
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       child: const Icon(
//                         Icons.play_arrow,
//                         color: Colors.white,
//                         size: 40,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: VideoProgressIndicator(
//                     _videoPlayerController!,
//                     allowScrubbing: true,
//                     colors: VideoProgressColors(
//                       playedColor: Colors.blue,
//                       bufferedColor: Colors.white24,
//                       backgroundColor: Colors.white10,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : const Center(child: CircularProgressIndicator());
//     } else {
//       return const Center(child: Text("No Video Available"));
//     }
//   }
// }
