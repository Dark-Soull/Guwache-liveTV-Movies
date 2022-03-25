import 'dart:convert';


class SingleTvSeriesModel {
  SingleTvSeriesModel({
    required this.videosId,
    required this.title,
    required this.description,
    required this.slug,
    required this.release,
    required this.runtime,
    required this.videoQuality,
    required this.isTvseries,
    required this.isPaid,
    required this.enableDownload,
    required this.thumbnailUrl,
    required this.posterUrl,
    required this.genre,
    required this.country,
    required this.director,
    required this.writer,
    required this.cast,
    required this.castAndCrew,
    required this.traillerYoutubeSource,
    required this.season,
    required this.relatedTvseries,
  });

  String videosId;
  String title;
  String description;
  String slug;
  DateTime release;
  String runtime;
  String videoQuality;
  String isTvseries;
  String isPaid;
  String enableDownload;
  String thumbnailUrl;
  String posterUrl;
  List<Genre> genre;
  List<Country> country;
  List<Cast> director;
  List<Cast> writer;
  List<Cast> cast;
  List<Cast> castAndCrew;
  String traillerYoutubeSource;
  List<Season> season;
  List<RelatedTvseries> relatedTvseries;

  factory SingleTvSeriesModel.fromJson(Map<String, dynamic> json){
    var genre=json["genre"] as List;
    List<Genre> GenreList=genre.map((list) => Genre.fromJson(list)).toList();

    var country=json["country"] as List;
    List<Country> CountryList=country.map((list) => Country.fromJson(list)).toList();

    var director=json["director"] as List;
    List<Cast> DirectorList=director.map((list) => Cast.fromJson(list)).toList();

    var writter=json["writer"] as List;
    List<Cast> WritterList=writter.map((list) => Cast.fromJson(list)).toList();

    var cast=json["cast"] as List;
    List<Cast> CastList=cast.map((list) => Cast.fromJson(list)).toList();

    var cast2= json["cast_and_crew"] as List;
    List<Cast> Cast_Crew=cast2.map((list) => Cast.fromJson(list)).toList();

    var related= json["related_tvseries"] as List;
    List<RelatedTvseries> RelatedList=related.map((list) => RelatedTvseries.fromJson(list)).toList();

    var sea= json["season"] as List;
    List<Season> SeasonList=sea.map((list) => Season.fromJson(list)).toList();


    return SingleTvSeriesModel(
      videosId: json["videos_id"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      slug: json["slug"] ?? '',
      release: DateTime.parse(json["release"]),
      runtime: json["runtime"] ?? '',
      videoQuality: json["video_quality"] ?? '',
      isTvseries: json["is_tvseries"] ?? '',
      isPaid: json["is_paid"] ?? '',
      enableDownload: json["enable_download"] ?? '',
      thumbnailUrl: json["thumbnail_url"] ?? '',
      posterUrl: json["poster_url"] ?? '',
      genre: GenreList,
      country: CountryList,
      director: DirectorList,
      writer: WritterList,
      cast: CastList,
      castAndCrew: Cast_Crew,
      traillerYoutubeSource: json["trailler_youtube_source"] ?? '',
      season: SeasonList,
      relatedTvseries: RelatedList,
    );
  }
}

class RelatedTvseries {
  RelatedTvseries({
    required this.videosId,
    required this.genre,
    required this.country,
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

  String videosId;
  String genre;
  String country;
  String title;
  String description;
  String slug;
  String release;
  String isPaid;
  String isTvseries;
  String runtime;
  String videoQuality;
  String thumbnailUrl;
  String posterUrl;

  factory RelatedTvseries.fromJson(Map<String, dynamic> json){
    return RelatedTvseries(
      videosId: json["videos_id"] ?? '',
      genre: json["genre"] ?? '',
      country: json["country"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      slug: json["slug"] ?? '',
      release: json["release"] ?? '',
      isPaid: json["is_paid"] ?? '',
      isTvseries: json["is_tvseries"] ?? '',
      runtime: json["runtime"] ?? '',
      videoQuality: json["video_quality"] ?? '',
      thumbnailUrl: json["thumbnail_url"] ?? '',
      posterUrl: json["poster_url"] ?? '',
    );
  }
}


class Cast {
  Cast({
    required this.starId,
    required this.name,
    required this.url,
    required this.imageUrl,
  });

  String starId;
  String name;
  String url;
  String imageUrl;

  factory Cast.fromJson(Map<String, dynamic> json){
    return Cast(
      starId: json["star_id"] ?? '',
      name: json["name"] ?? '',
      url: json["url"] ?? '',
      imageUrl: json["image_url"] ?? '',
    );
  }
}

class Country {
  Country({
    required this.countryId,
    required this.name,
    required this.url,
  });

  String countryId;
  String name;
  String url;

  factory Country.fromJson(Map<String, dynamic> json){
    return Country(
      countryId: json["country_id"] ?? '',
      name: json["name"] ?? '',
      url: json["url"] ?? '',
    );
  }
}

class Genre {
  Genre({
    required this.genreId,
    required this.name,
    required this.url,
  });

  String genreId;
  String name;
  String url;

  factory Genre.fromJson(Map<String, dynamic> json){
    return Genre(
      genreId: json["genre_id"] ?? '',
      name: json["name"] ?? '',
      url: json["url"] ?? '',
    );
  }
}

class Season {
  Season({
    required this.seasonsId,
    required this.seasonsName,
    required this.episodes,
    required this.enableDownload,
    required this.downloadLinks,
  });

  String seasonsId;
  String seasonsName;
  List<Episode> episodes;
  String enableDownload;
  List<DownloadLink> downloadLinks;

  factory Season.fromJson(Map<String, dynamic> json){
    var downloadLink=json["download_links"] as List;
    List<DownloadLink> finalLinks=downloadLink.map((link) => DownloadLink.fromJson(link)).toList();

    var epi=json["episodes"] as List;
    List<Episode> finalepi=epi.map((link) => Episode.fromJson(link)).toList();

    return Season(
      seasonsId: json["seasons_id"] ?? '',
      seasonsName: json["seasons_name"] ?? '',
      episodes: finalepi,
      enableDownload: json["enable_download"] ?? '',
      downloadLinks: finalLinks,
    );
  }
}

class DownloadLink {
  DownloadLink({
    required this.downloadLinkId,
    required this.label,
    required this.videosId,
    required this.resolution,
    required this.fileSize,
    required this.downloadUrl,
    required this.inAppDownload,
  });

  String downloadLinkId;
  String label;
  String videosId;
  String resolution;
  String fileSize;
  String downloadUrl;
  bool inAppDownload;

  factory DownloadLink.fromJson(Map<String, dynamic> json) {
    return DownloadLink(
      downloadLinkId: json["download_link_id"] ?? '',
      label: json["label"] ?? '',
      videosId: json["videos_id"] ?? '',
      resolution: json["resolution"] ?? '',
      fileSize: json["file_size"] ?? '',
      downloadUrl: json["download_url"] ?? '',
      inAppDownload: json["in_app_download"] ?? true,
    );
  }
}






class Episode {
  Episode({
    required this.episodesId,
    required this.episodesName,
    required this.streamKey,
    required this.fileType,
    required this.imageUrl,
    required this.fileUrl,
    required this.subtitle,
  });

  String episodesId;
  String episodesName;
  String streamKey;
  String fileType;
  String imageUrl;
  String fileUrl;
  List<Subtitle> subtitle;

  factory Episode.fromJson(Map<String, dynamic> json){
    var sub= json["subtitle"] as List;
    List<Subtitle> SubList=sub.map((list) => Subtitle.fromJson(list)).toList();
    return Episode(
      episodesId: json["episodes_id"] ?? '',
      episodesName: json["episodes_name"] ?? '',
      streamKey: json["stream_key"] ?? '',
      fileType: json["file_type"] ?? '',
      imageUrl: json["image_url"] ?? '',
      fileUrl: json["file_url"] ?? '',
      subtitle: SubList,
    );
  }
}


class Subtitle {
  Subtitle({
    required this.subtitleId,
    required this.videosId,
    required this.videoFileId,
    required this.language,
    required this.kind,
    required this.url,
    required this.srclang,
  });

  String subtitleId;
  String videosId;
  String videoFileId;
  String language;
  String kind;
  String url;
  String srclang;

  factory Subtitle.fromJson(Map<String, dynamic> json){
    return Subtitle(
      subtitleId: json["subtitle_id"] ?? '',
      videosId: json["videos_id"] ?? '',
      videoFileId: json["video_file_id"] ?? '',
      language: json["language"] ?? '',
      kind: json["kind"] ?? '',
      url: json["url"] ?? '',
      srclang: json["srclang"] ?? '',
    );
  }
}