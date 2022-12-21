class PopularTVShowModel {
  PopularTVShowModel({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  PopularTVShowModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = List.from(json['results']).map((e) => PopularTVShowModelResults.fromJson(e)).toList();
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
  }
  late final int page;
  late final List<PopularTVShowModelResults> results;
  late final int totalResults;
  late final int totalPages;
}

class PopularTVShowModelResults {
  PopularTVShowModelResults({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  PopularTVShowModelResults.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    popularity = json['popularity'];
    id = json['id'];
    backdropPath = json['backdrop_path'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    firstAirDate = json['first_air_date'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    originalLanguage = json['original_language'];
    voteCount = json['vote_count'];
    name = json['name'];
    originalName = json['original_name'];
  }
  late final String posterPath;
  late final double popularity;
  late final int id;
  late final String? backdropPath;
  late final num voteAverage;
  late final String overview;
  late final String firstAirDate;
  late final List<String> originCountry;
  late final List<int> genreIds;
  late final String originalLanguage;
  late final num voteCount;
  late final String name;
  late final String originalName;
}
