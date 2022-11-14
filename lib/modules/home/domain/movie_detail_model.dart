class MovieDetailResModel {
  MovieDetailResModel({
    required this.status,
    required this.statusMessage,
    required this.data,
  });
  MovieDetailResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = MovieDetailResModelData.fromJson(json['data']);
  }
  late final String status;
  late final String statusMessage;
  late final MovieDetailResModelData data;
}

class MovieDetailResModelData {
  MovieDetailResModelData({
    required this.movie,
  });
  MovieDetailResModelData.fromJson(Map<String, dynamic> json) {
    movie = Movie.fromJson(json['movie']);
  }
  late final Movie movie;
}

class Movie {
  Movie({
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
    required this.downloadCount,
    required this.likeCount,
    required this.descriptionIntro,
    required this.descriptionFull,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  Movie.fromJson(Map<String, dynamic> json) {
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
    downloadCount = json['download_count'];
    likeCount = json['like_count'];
    descriptionIntro = json['description_intro'];
    descriptionFull = json['description_full'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  late final int id;
  late final String url;
  late final String imdbCode;
  late final String title;
  late final String titleEnglish;
  late final String titleLong;
  late final String slug;
  late final int year;
  late final num rating;
  late final int runtime;
  late final List<String>? genres;
  late final int downloadCount;
  late final int likeCount;
  late final String descriptionIntro;
  late final String descriptionFull;
  late final String ytTrailerCode;
  late final String language;
  late final String mpaRating;
  late final String backgroundImage;
  late final String backgroundImageOriginal;
  late final String smallCoverImage;
  late final String mediumCoverImage;
  late final String largeCoverImage;
  late final List<Torrents> torrents;
  late final String dateUploaded;
  late final int dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['url'] = url;
    _data['imdb_code'] = imdbCode;
    _data['title'] = title;
    _data['title_english'] = titleEnglish;
    _data['title_long'] = titleLong;
    _data['slug'] = slug;
    _data['year'] = year;
    _data['rating'] = rating;
    _data['runtime'] = runtime;
    _data['genres'] = genres;
    _data['download_count'] = downloadCount;
    _data['like_count'] = likeCount;
    _data['description_intro'] = descriptionIntro;
    _data['description_full'] = descriptionFull;
    _data['yt_trailer_code'] = ytTrailerCode;
    _data['language'] = language;
    _data['mpa_rating'] = mpaRating;
    _data['background_image'] = backgroundImage;
    _data['background_image_original'] = backgroundImageOriginal;
    _data['small_cover_image'] = smallCoverImage;
    _data['medium_cover_image'] = mediumCoverImage;
    _data['large_cover_image'] = largeCoverImage;

    _data['date_uploaded'] = dateUploaded;
    _data['date_uploaded_unix'] = dateUploadedUnix;
    return _data;
  }
}

class Torrents {
  Torrents({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });
  Torrents.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  late final String url;
  late final String hash;
  late final String quality;
  late final String type;
  late final int seeds;
  late final int peers;
  late final String size;
  late final int sizeBytes;
  late final String dateUploaded;
  late final int dateUploadedUnix;
}
