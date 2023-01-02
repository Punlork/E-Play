class UpcomingMoviesModel {
  UpcomingMoviesModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  UpcomingMoviesModel.fromJson(Map<String, dynamic> json) {
    dates = Dates.fromJson(json['dates']);
    page = json['page'];
    results =
        List.from(json['results']).map((e) => UpcomingMoviesModelResults.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  late final Dates dates;
  late final int page;
  late final List<UpcomingMoviesModelResults> results;
  late final int totalPages;
  late final int totalResults;
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });
  Dates.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
  late final String maximum;
  late final String minimum;
}

class UpcomingMoviesModelResults {
  UpcomingMoviesModelResults({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  UpcomingMoviesModelResults.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  late final bool adult;
  late final String? backdropPath;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final num popularity;
  late final String? posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final num? voteAverage;
  late final num voteCount;
}
