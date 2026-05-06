import 'dart:developer';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:lms_student/core/services/remote/endpoints.dart';

class VideoSourceHelper {
  static String? extractYoutubeId(String url) {
    String? id = YoutubePlayer.convertUrlToId(url);
    if (id != null) return id;
    try {
      Uri uri = Uri.parse(url);
      if (uri.pathSegments.contains('shorts') || uri.pathSegments.contains('live')) {
        return uri.pathSegments.last;
      }
    } catch (e) {
      log("Error parsing video URL: $e");
    }
    return null;
  }

  static String getFullServerUrl(String path) {
    return path.startsWith('http') ? path : '${EndPoint.mediaBaseUrl}$path';
  }
}
