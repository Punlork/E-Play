class TrendingModel {
  TrendingModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  TrendingModel.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        results = (json['results'] as List?)
            ?.map((dynamic e) => TrendingModelResults.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages = json['total_pages'] as int?,
        totalResults = json['total_results'] as int?;

  final int? page;
  final List<TrendingModelResults>? results;
  final int? totalPages;
  final int? totalResults;
}

class TrendingModelResults {
  TrendingModelResults({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.popularity,
  });

  TrendingModelResults.fromJson(Map<String, dynamic> json)
      : adult = json['adult'] as bool?,
        backdropPath = json['backdrop_path'] as String?,
        genreIds = (json['genre_ids'] as List?)?.map((dynamic e) => e as int).toList(),
        id = json['id'] as int?,
        originalLanguage = json['original_language'] as String?,
        originalTitle = json['original_title'] as String?,
        overview = json['overview'] as String?,
        posterPath = json['poster_path'] as String?,
        releaseDate = json['release_date'] as String?,
        title = json['title'] as String?,
        video = json['video'] as bool?,
        voteAverage = json['vote_average'] as double?,
        voteCount = json['vote_count'] as int?,
        popularity = json['popularity'] as double?;

  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final double? popularity;
}
