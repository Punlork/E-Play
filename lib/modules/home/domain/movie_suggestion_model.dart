class MovieSuggestion {
  MovieSuggestion({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  late final int page;
  late final List<MovieSuggestionResults> results;
  late final int totalPages;
  late final int totalResults;

  MovieSuggestion.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results']).map((e) => MovieSuggestionResults.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class MovieSuggestionResults {
  MovieSuggestionResults({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  late final bool adult;
  late final String? backdropPath;
  late final int id;
  late final String title;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final String? posterPath;
  late final String mediaType;
  late final List<int> genreIds;
  late final double popularity;
  late final String releaseDate;
  late final bool video;
  late final num? voteAverage;
  late final int voteCount;

  MovieSuggestionResults.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    popularity = json['popularity'];
    releaseDate = json['release_date'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}
