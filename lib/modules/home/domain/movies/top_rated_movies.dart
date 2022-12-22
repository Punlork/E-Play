class TopRatedMovies {
  TopRatedMovies({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  TopRatedMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results']).map((e) => TopRatedMoviesResults.fromJson(e)).toList();
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
  }
  late final int page;
  late final List<TopRatedMoviesResults> results;
  late final int totalResults;
  late final int totalPages;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['results'] = results.map((e) => e.toJson()).toList();
    _data['total_results'] = totalResults;
    _data['total_pages'] = totalPages;
    return _data;
  }
}

class TopRatedMoviesResults {
  TopRatedMoviesResults({
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

  TopRatedMoviesResults.fromJson(Map<String, dynamic> json) {
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
  late final double voteAverage;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['poster_path'] = posterPath;
    _data['adult'] = adult;
    _data['overview'] = overview;
    _data['release_date'] = releaseDate;
    _data['genre_ids'] = genreIds;
    _data['id'] = id;
    _data['original_title'] = originalTitle;
    _data['original_language'] = originalLanguage;
    _data['title'] = title;
    _data['backdrop_path'] = backdropPath;
    _data['popularity'] = popularity;
    _data['vote_count'] = voteCount;
    _data['video'] = video;
    _data['vote_average'] = voteAverage;
    return _data;
  }
}
