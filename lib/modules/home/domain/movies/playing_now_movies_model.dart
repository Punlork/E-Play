class NowPlayMoviesModel {
  NowPlayMoviesModel({
    required this.page,
    required this.results,
    required this.dates,
    required this.totalPages,
    required this.totalResults,
  });

  NowPlayMoviesModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results']).map((e) => NowPlayMoviesModelResults.fromJson(e)).toList();
    dates = NowPlayingDates.fromJson(json['dates']);
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  late final int page;
  late final List<NowPlayMoviesModelResults> results;
  late final NowPlayingDates dates;
  late final int totalPages;
  late final int totalResults;
}

class NowPlayMoviesModelResults {
  NowPlayMoviesModelResults({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  NowPlayMoviesModelResults.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    originalTitle = json['original_title'];
    originalLanguage = json['original_language'];
    title = json['title'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'];
  }
  late final String posterPath;
  late final bool adult;
  late final String overview;
  late final String releaseDate;
  late final List<int> genreIds;
  late final int id;
  late final String originalTitle;
  late final String originalLanguage;
  late final String title;
  late final String backdropPath;
  late final double popularity;
  late final int voteCount;
  late final bool video;
  late final num? voteAverage;
}

class NowPlayingDates {
  NowPlayingDates({
    required this.maximum,
    required this.minimum,
  });

  NowPlayingDates.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
  late final String maximum;
  late final String minimum;
}
