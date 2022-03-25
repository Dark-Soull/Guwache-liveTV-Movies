class HomeModel {

  Slider slider;
  List<PopularStar> popularStars;
  List<AllCountry> allCountry;
  List<AllGenre> allGenre;
  List<FeaturedTvChannel> featuredTvChannel;
  List<LatestMovie> latestMovies;
  List<LatestTVseries> latestTvseries;
  List<FeaturesGenreMovie> featuresGenreAndMovie;

  HomeModel({
    required this.slider,
    required this.popularStars,
    required this.allCountry,
    required this.allGenre,
    required this.featuredTvChannel,
    required this.latestMovies,
    required this.latestTvseries,
    required this.featuresGenreAndMovie,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json){

    var popStar=json["popular_stars"] as List;
    List<PopularStar> popularStar=popStar.map((popularstar) => PopularStar.fromJson(popularstar)).toList();

    var country=json["all_country"] as List;
    List<AllCountry> allCountry=country.map((country) => AllCountry.fromJson(country)).toList();

    var genre=json["all_genre"] as List;
    List<AllGenre> allGenre=genre.map((Genre) => AllGenre.fromJson(Genre)).toList();

    var featuredTv=json["featured_tv_channel"] as List;
    List<FeaturedTvChannel> featuredTvchannel=featuredTv.map((tv) => FeaturedTvChannel.fromJson(tv)).toList();

    var Movie=json["latest_movies"] as List;
    List<LatestMovie> latestMovies=Movie.map((movies) => LatestMovie.fromJson(movies)).toList();

    var Series=json["latest_tvseries"] as List;
    List<LatestTVseries> latestTvseries=Series.map((series) => LatestTVseries.fromJson(series)).toList();

    var GenerMovie=json["features_genre_and_movie"] as List;
    List<FeaturesGenreMovie> featureGenre=GenerMovie.map((data) => FeaturesGenreMovie.fromJson(data)).toList();

    return HomeModel(
      slider: Slider.fromJson(json["slider"]),
      popularStars: popularStar,
      allCountry: allCountry,
      allGenre: allGenre,
      featuredTvChannel: featuredTvchannel,
      latestMovies: latestMovies,
      latestTvseries: latestTvseries,
      featuresGenreAndMovie: featureGenre,
    );
  }





}

class AllCountry {

  String countryId;
  String name;
  String description;
  String slug;
  String url;
  String imageUrl;

  AllCountry({
    required this.countryId,
    required this.name,
    required this.description,
    required this.slug,
    required this.url,
    required this.imageUrl,
  });

  factory AllCountry.fromJson(Map<String, dynamic> json){
    return AllCountry(
      countryId: json["country_id"] as String,
      name: json["name"] as String,
      description: json["description"] as String,
      slug: json["slug"] as String,
      url: json["url"] as String,
      imageUrl: json["image_url"] as String,
    );
  }

}

class FeaturesGenreMovie {

  String genreId;
  String name;
  String description;
  String slug;
  String url;
  List<Videos> videos;

  FeaturesGenreMovie({
    required this.genreId,
    required this.name,
    required this.description,
    required this.slug,
    required this.url,
    required this.videos,
  });


  factory FeaturesGenreMovie.fromJson(Map<String, dynamic> json){
    var list= json["videos"] as List;
    List<Videos> videos=list.map((videos) => Videos.fromJson(videos)).toList();
    return FeaturesGenreMovie(
      genreId: json["genre_id"],
      name: json["name"],
      description: json["description"],
      slug: json["slug"],
      url: json["url"],
      videos:videos,
    );
  }
}

class Videos{
  String videosId;
  String title;
  String description;
  String slug;
  String release;
  String isTvseries;
  String isPaid;
  String runtime;
  String videoQuality;
  String thumbnailUrl;
  String posterUrl;

  Videos({required this.videosId,
      required this.title,
      required this.description,
      required this.slug,
      required this.release,
      required this.isTvseries,
      required this.isPaid,
      required this.runtime,
      required this.videoQuality,
      required this.thumbnailUrl,
      required this.posterUrl});

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      videosId: json["videos_id"]as String,
      title: json["title"]as String,
      description: json["description"]as String,
      slug: json["slug"]as String,
      release: json["release"]as String,
      isTvseries: json["is_tvseries"]as String,
      isPaid: json["is_paid"]as String,
      runtime: json["runtime"]as String,
      videoQuality: json["video_quality"]as String,
      thumbnailUrl: json["thumbnail_url"]as String,
      posterUrl: json["poster_url"]as String,
    );
  }
}



class AllGenre {

  String genreId;
  String name;
  String description;
  String slug;
  String url;
  String imageUrl;

  AllGenre({
    required this.genreId,
    required this.name,
    required this.description,
    required this.slug,
    required this.url,
    required this.imageUrl,
  });

  factory AllGenre.fromJson(Map<String, dynamic> json){
    return AllGenre(
      genreId: json["genre_id"] as String,
      name: json["name"] as String,
      description: json["description"] as String,
      slug: json["slug"] as String,
      url: json["url"] as String,
      imageUrl: json["image_url"] as String,
    );
  }

}




class LatestMovie {

  String videosId;
  String title;
  String description;
  String slug;
  String release;
  String isPaid;
  String runtime;
  String videoQuality;
  String thumbnailUrl;
  String posterUrl;

  LatestMovie({
    required this.videosId,
    required this.title,
    required this.description,
    required this.slug,
    required this.release,
    required this.isPaid,
    required this.runtime,
    required this.videoQuality,
    required this.thumbnailUrl,
    required this.posterUrl,
  });


  factory LatestMovie.fromJson(Map<String, dynamic> json){
    return LatestMovie(
      videosId: json["videos_id"] as String,
      title: json["title"]as String,
      description: json["description"] as String,
      slug: json["slug"] as String,
      release: json["release"] as String,
      isPaid: json["is_paid"] as String,
      runtime: json["runtime"] as String,
      videoQuality: json["video_quality"] as String,
      thumbnailUrl: json["thumbnail_url"] as String,
      posterUrl: json["poster_url"]as String,
    );
  }
}

class LatestTVseries {

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

  LatestTVseries({
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


  factory LatestTVseries.fromJson(Map<String, dynamic> json){
    return LatestTVseries(
      videosId: json["videos_id"] as String,
      title: json["title"]as String,
      description: json["description"] as String,
      slug: json["slug"] as String,
      isPaid: json["is_paid"] as String,
      release: json["release"] as String,
      runtime: json["runtime"] as String,
      videoQuality: json["video_quality"] as String,
      thumbnailUrl: json["thumbnail_url"] as String,
      posterUrl: json["poster_url"]as String,
    );
  }
}




class FeaturedTvChannel {

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

  FeaturedTvChannel({
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



  factory FeaturedTvChannel.fromJson(Map<String, dynamic> json){
    return FeaturedTvChannel(
      liveTvId: json["live_tv_id"]as String,
      tvName: json["tv_name"]as String,
      isPaid: json["is_paid"]as String,
      description: json["description"]as String,
      slug: json["slug"]as String,
      streamFrom: json["stream_from"]as String,
      streamLabel: json["stream_label"]as String,
      streamUrl: json["stream_url"]as String,
      thumbnailUrl: json["thumbnail_url"]as String,
      posterUrl: json["poster_url"]as String,
    );
  }

}

class PopularStar {

  String starId;
  String starName;
  String imageUrl;

  PopularStar({
    required this.starId,
    required this.starName,
    required this.imageUrl,
  });

  factory PopularStar.fromJson(Map<String, dynamic> json){
    return PopularStar(
      starId: json["star_id"]as String,
      starName: json["star_name"]as String,
      imageUrl: json["image_url"]as String,
    );
  }
}

class Slider {

  String sliderType;
  List<Slide> slide;

  Slider({
    required this.sliderType,
    required this.slide,
  });

  factory Slider.fromJson(Map<String, dynamic> json){
    var list=json["slide"] as List;
    List<Slide> slideList=list.map((slide) => Slide.fromJson(slide)).toList();
    return Slider(
      sliderType: json["slider_type"]as String,
      slide: slideList,
    );
  }
}

class Slide {

  String id;
  String title;
  String description;
  String imageLink;
  String slug;
  String actionType;
  String actionBtnText;
  String actionId;
  String actionUrl;

  Slide({
    required this.id,
    required this.title,
    required this.description,
    required this.imageLink,
    required this.slug,
    required this.actionType,
    required this.actionBtnText,
    required this.actionId,
    required this.actionUrl,
  });

  factory Slide.fromJson(Map<String, dynamic> json){
    return Slide(
      id: json["id"]as String,
      title: json["title"]as String,
      description: json["description"]as String,
      imageLink: json["image_link"]as String,
      slug: json["slug"]as String,
      actionType: json["action_type"] as String,
      actionBtnText: json["action_btn_text"]as String,
      actionId: json["action_id"]as String,
      actionUrl: json["action_url"]as String,
    );
  }

}


