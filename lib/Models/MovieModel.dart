class MovieModel {
  final String videosId;
  final String title;
  final String description;
  final String slug;
  final String release;
  final String isPaid;
  final String isTvseries;
  final String runtime;
  final String videoQuality;
  final String thumbnailUrl;
  final String posterUrl;

  MovieModel({
    required this.videosId,
    required this.title,
    required this.description,
    required this.slug,
    required this.release,
    required this.isPaid,
    required this.isTvseries,
    required this.runtime,
    required this.videoQuality,
    required this.thumbnailUrl,
    required this.posterUrl,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json){
    return MovieModel(
    videosId: json["videos_id"] as String,
    title: json["title"] as String,
    description: json["description"] as String,
    slug: json["slug"] as String,
    release: json["release"] as String,
    isPaid: json["is_paid"] as String,
    isTvseries: json["is_tvseries"] as String,
    runtime: json["runtime"] as String,
    videoQuality: json["video_quality"] as String,
    thumbnailUrl: json["thumbnail_url"] as String,
    posterUrl: json["poster_url"] as String,
  );
  }

}



