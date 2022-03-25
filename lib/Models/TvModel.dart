import 'dart:convert';



class TvModel {

  String liveTvCategoryId;
  String title;
  String description;
  List<Channel> channels;

  TvModel({
    required this.liveTvCategoryId,
    required this.title,
    required this.description,
    required this.channels,
  });


  factory TvModel.fromJson(Map<String, dynamic> json){
    var Tv=json["channels"] as List;
    List<Channel> Tvchannel=Tv.map((channel) => Channel.fromJson(channel)).toList();
    return TvModel(
      liveTvCategoryId: json["live_tv_category_id"],
      title: json["title"],
      description: json["description"],
      channels: Tvchannel,
    );
  }
}




class Channel {
  Channel({
    required this.liveTvId,
    required this.tvName,
    required this.isPaid,
    required this.description,
    required this.slug,
    required this.streamFrom,
    required this.streamLabel,
    required this.streamUrl,
    required this.thumbnailUrl,
    required this.posterUrl,
  });

  String liveTvId;
  String tvName;
  String isPaid;
  String description;
  String slug;
  String streamFrom;
  String streamLabel;
  String streamUrl;
  String thumbnailUrl;
  String posterUrl;

  factory Channel.fromJson(Map<String, dynamic> json){
    return Channel(
      liveTvId: json["live_tv_id"],
      tvName: json["tv_name"],
      isPaid: json["is_paid"],
      description: json["description"],
      slug: json["slug"],
      streamFrom: json["stream_from"],
      streamLabel: json["stream_label"],
      streamUrl: json["stream_url"],
      thumbnailUrl: json["thumbnail_url"],
      posterUrl: json["poster_url"],
    );
  }
}
