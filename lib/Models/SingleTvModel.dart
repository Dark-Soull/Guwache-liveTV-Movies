import 'dart:convert';


class SingleTvModel {
  SingleTvModel({
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
    required this.additionalMediaSource,
    required this.allTvChannel,
    required this.currentProgramTitle,
    required this.currentProgramTime,
    required this.programGuide,
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
  List<AdditionalMediaSource> additionalMediaSource;
  List<AllTvChannel> allTvChannel;
  String currentProgramTitle;
  String currentProgramTime;
  List<dynamic> programGuide;

  factory SingleTvModel.fromJson(Map<String, dynamic> json){

    var additional=json["additional_media_source"] as List;
    List<AdditionalMediaSource> addi=additional.map((index) => AdditionalMediaSource.fromJson(index)).toList();

    var allTv=json["all_tv_channel"] as List;
    List<AllTvChannel> AllTV=allTv.map((index) => AllTvChannel.fromJson(index)).toList();

      return SingleTvModel(
        liveTvId: json["live_tv_id"] ?? '',
        tvName: json["tv_name"] ?? '',
        isPaid: json["is_paid"] ?? '',
        description: json["description"] ?? '',
        slug: json["slug"] ?? '',
        streamFrom: json["stream_from"] ?? '',
        streamLabel: json["stream_label"] ?? '',
        streamUrl: json["stream_url"] ?? '',
        thumbnailUrl: json["thumbnail_url"] ?? '',
        posterUrl: json["poster_url"] ?? '',
        additionalMediaSource: addi,
        allTvChannel: AllTV,
        currentProgramTitle: json["current_program_title"] ?? '',
        currentProgramTime: json["current_program_time"] ?? '',
        programGuide: List<dynamic>.from(json["program_guide"].map((x) => x)),
      );

}
}

class AdditionalMediaSource {
  AdditionalMediaSource({
    required this.liveTvId,
    required this.streamKey,
    required this.source,
    required this.label,
    required this.url,
  });

  String liveTvId;
  String streamKey;
  String source;
  String label;
  String url;

  factory AdditionalMediaSource.fromJson(Map<String, dynamic> json){
      return AdditionalMediaSource(
        liveTvId: json["live_tv_id"] ?? '',
        streamKey: json["stream_key"] ?? '',
        source: json["source"] ?? '',
        label: json["label"] ?? '',
        url: json["url"] ?? '',
      );
}
}

class AllTvChannel {
  AllTvChannel({
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

  factory AllTvChannel.fromJson(Map<String, dynamic> json){
    return AllTvChannel(
      liveTvId: json["live_tv_id"] ?? '',
      tvName: json["tv_name"] ?? '',
      isPaid: json["is_paid"] ?? '',
      description: json["description"] ?? '',
      slug: json["slug"] ?? '',
      streamFrom: json["stream_from"] ?? '',
      streamLabel: json["stream_label"] ?? '',
      streamUrl: json["stream_url"] ?? '',
      thumbnailUrl: json["thumbnail_url"] ?? '',
      posterUrl: json["poster_url"] ?? '',
    );
  }
}
