class VideoModel {
  String slug;
  String title;
  String videoUrl;
  String videoUpload;
  int order;
  String course;

  String? duration;
  bool isCompleted;
  bool isLocked;
  bool isPlaying;

  VideoModel({
    required this.slug,
    required this.title,
    required this.videoUrl,
    required this.videoUpload,
    required this.order,
    required this.course,
    this.duration = "00:00",
    this.isCompleted = false,
    this.isLocked = false,
    this.isPlaying = false,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    slug: json["slug"],
    title: json["title"],
    videoUrl: json["video_url"],
    videoUpload: json["video_upload"],
    order: json["order"],
    course: json["course"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "title": title,
    "video_url": videoUrl,
    "video_upload": videoUpload,
    "order": order,
    "course": course,
  };
}
