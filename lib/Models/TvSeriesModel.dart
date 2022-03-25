import 'dart:convert';


class TvSeriesModel {
  String videosId;
  String title;
  String description;
  String slug;
  String isPaid;
  String release;
  String runtime;
  String videoQuality;
  String thumbnailUrl;
  String posterUrl;

  TvSeriesModel({
    required this.videosId,
    required this.title,
    required this.description,
    required this.slug,
    required this.isPaid,
    required this.release,
    required this.runtime,
    required this.videoQuality,
    required this.thumbnailUrl,
    required this.posterUrl,
  });


  factory TvSeriesModel.fromJson(Map<String, dynamic> json){
    return TvSeriesModel(
      videosId: json["videos_id"],
      title: json["title"],
      description: json["description"],
      slug: json["slug"],
      isPaid: json["is_paid"],
      release: json["release"],
      runtime: json["runtime"],
      videoQuality: json["video_quality"],
      thumbnailUrl: json["thumbnail_url"],
      posterUrl: json["poster_url"],
    );
  }
}
