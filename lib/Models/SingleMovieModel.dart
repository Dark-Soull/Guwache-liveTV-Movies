import 'dart:convert';


class SingleMovieModel {
  SingleMovieModel({
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
    required this.downloadLinks,
    required this.thumbnailUrl,
    required this.posterUrl,
    required this.videos,
    required this.genre,
    required this.country,
    required this.director,
    required this.writer,
    required this.cast,
    required this.castAndCrew,
    required this.traillerYoutubeSource,
    required this.relatedMovie,
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
  List<DownloadLink> downloadLinks;
  String thumbnailUrl;
  String posterUrl;
  List<Video> videos;
  List<Genre> genre;
  List<Country> country;
  List<Cast> director;
  List<Cast> writer;
  List<Cast> cast;
  List<Cast> castAndCrew;
  String traillerYoutubeSource;
  List<RelatedMovie> relatedMovie;

  factory SingleMovieModel.fromJson(Map<String, dynamic> json){
    var downloadLink=json["download_links"] as List;
    List<DownloadLink> finalLinks=downloadLink.map((link) => DownloadLink.fromJson(link)).toList();

    var videosList=json["videos"] as List;
    List<Video> VideoList=videosList.map((list) => Video.fromJson(list)).toList();

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

    var related= json["related_movie"] as List;
    List<RelatedMovie> RelatedList=related.map((list) => RelatedMovie.fromJson(list)).toList();

    return SingleMovieModel(
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
      downloadLinks: finalLinks,
      thumbnailUrl: json["thumbnail_url"] ?? '',
      posterUrl: json["poster_url"] ?? '',
      videos: VideoList,
      genre: GenreList,
      country: CountryList,
      director: DirectorList,
      writer: WritterList,
      cast: CastList,
      castAndCrew: Cast_Crew,
      traillerYoutubeSource: json["trailler_youtube_source"] ?? '',
      relatedMovie: RelatedList,
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

  factory Cast.fromJson(Map<String, dynamic> json) {
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

class RelatedMovie {
  RelatedMovie({
    required this.videosId,
    required this.genre,
    required this.country,
    required this.title,
    required this.description,
    required this.slug,
    required this.isPaid,
    required this.isTvseries,
    required this.release,
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
  String isPaid;
  String isTvseries;
  String release;
  String runtime;
  String videoQuality;
  String thumbnailUrl;
  String posterUrl;

  factory RelatedMovie.fromJson(Map<String, dynamic> json){
    return RelatedMovie(
      videosId: json["videos_id"] ?? '',
      genre: json["genre"] ?? '',
      country: json["country"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      slug: json["slug"] ?? '',
      isPaid: json["is_paid"] ?? '',
      isTvseries: json["is_tvseries"] ?? '',
      release: json["release"] ?? '',
      runtime: json["runtime"] ?? '',
      videoQuality: json["video_quality"] ?? '',
      thumbnailUrl: json["thumbnail_url"] ?? '',
      posterUrl: json["poster_url"] ?? '',
    );
  }
}

class Video {
  String videoFileId;
  String label;
  String streamKey;
  String fileType;
  String fileUrl;
  List<Subtitle> subtitle;
  Video({
    required this.videoFileId,
    required this.label,
    required this.streamKey,
    required this.fileType,
    required this.fileUrl,
    required this.subtitle,
  });


  factory Video.fromJson(Map<String, dynamic> json){
    var sub= json["subtitle"] as List;
    List<Subtitle> SubList=sub.map((list) => Subtitle.fromJson(list)).toList();
    return Video(
      videoFileId: json["video_file_id"] ?? '',
      label: json["label"] ?? '',
      streamKey: json["stream_key"] ?? '',
      fileType: json["file_type"] ?? '',
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


