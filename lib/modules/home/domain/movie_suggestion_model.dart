class MovieSuggestionResModel {
  MovieSuggestionResModel({
    required this.status,
    required this.statusMessage,
    required this.data,
  });
  late final String status;
  late final String statusMessage;
  late final MovieSuggestionResModelData data;

  MovieSuggestionResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = MovieSuggestionResModelData.fromJson(json['data']);
  }
}

class MovieSuggestionResModelData {
  MovieSuggestionResModelData({
    required this.movieCount,
    required this.movies,
  });
  late final int movieCount;
  late final List<Movies> movies;

  MovieSuggestionResModelData.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    movies = List.from(json['movies']).map((e) => Movies.fromJson(e)).toList();
  }
}

class Movies {
  Movies({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.synopsis,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.state,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });
  late final int id;
  late final String url;
  late final String imdbCode;
  late final String title;
  late final String titleEnglish;
  late final String titleLong;
  late final String slug;
  late final int year;
  late final num? rating;
  late final int runtime;
  late final List<String>? genres;
  late final String summary;
  late final String descriptionFull;
  late final String synopsis;
  late final String ytTrailerCode;
  late final String language;
  late final String mpaRating;
  late final String backgroundImage;
  late final String backgroundImageOriginal;
  late final String smallCoverImage;
  late final String mediumCoverImage;
  late final String state;
  late final List<Torrents> torrents;
  late final String? dateUploaded;
  late final int? dateUploadedUnix;

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'] != null ? List.castFrom<dynamic, String>(json['genres']) : null;
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    state = json['state'];
    torrents = List.from(json['torrents']).map((e) => Torrents.fromJson(e)).toList();
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
}

class Torrents {
  Torrents({
    required this.url,
    required this.hash,
    required this.quality,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });
  late final String url;
  late final String hash;
  late final String quality;
  late final int seeds;
  late final int peers;
  late final String size;
  late final int sizeBytes;
  late final String dateUploaded;
  late final int dateUploadedUnix;

  Torrents.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
}
