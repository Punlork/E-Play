class TvShowSuggestion {
  TvShowSuggestion({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  TvShowSuggestion.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results']).map((e) => TvShowSuggestionResults.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  late final int page;
  late final List<TvShowSuggestionResults> results;
  late final int totalPages;
  late final int totalResults;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['results'] = results.map((e) => e.toJson()).toList();
    _data['total_pages'] = totalPages;
    _data['total_results'] = totalResults;
    return _data;
  }
}

class TvShowSuggestionResults {
  TvShowSuggestionResults({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.originCountry,
    required this.posterPath,
    required this.popularity,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  TvShowSuggestionResults.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    firstAirDate = json['first_air_date'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    posterPath = json['poster_path'];
    popularity = json['popularity'];
    name = json['name'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  late final String backdropPath;
  late final String firstAirDate;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalName;
  late final String overview;
  late final List<String> originCountry;
  late final String posterPath;
  late final double popularity;
  late final String name;
  late final double? voteAverage;
  late final int voteCount;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['backdrop_path'] = backdropPath;
    _data['first_air_date'] = firstAirDate;
    _data['genre_ids'] = genreIds;
    _data['id'] = id;
    _data['original_language'] = originalLanguage;
    _data['original_name'] = originalName;
    _data['overview'] = overview;
    _data['origin_country'] = originCountry;
    _data['poster_path'] = posterPath;
    _data['popularity'] = popularity;
    _data['name'] = name;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }
}
