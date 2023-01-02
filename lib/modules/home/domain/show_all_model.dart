class ShowAllModel {
  ShowAllModel({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  factory ShowAllModel.fromJson(Map<String, dynamic> json) => ShowAllModel(
        page: json['page'],
        results: List<ShowAllModelResult>.from(
            json['results'].map((x) => ShowAllModelResult.fromJson(x))),
        totalResults: json['total_results'],
        totalPages: json['total_pages'],
      );

  final int page;
  final List<ShowAllModelResult> results;
  final int totalResults;
  final int totalPages;
}

class ShowAllModelResult {
  ShowAllModelResult({
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

  factory ShowAllModelResult.fromJson(Map<String, dynamic> json) => ShowAllModelResult(
        posterPath: json['poster_path'] ?? '',
        adult: json['adult'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalTitle: json['original_title'],
        originalLanguage: json['original_language'],
        title: json['title'] ?? json['name'],
        backdropPath: json['backdrop_path'] ?? '',
        popularity: json['popularity'].toDouble(),
        voteCount: json['vote_count'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
      );

  final String posterPath;
  final bool? adult;
  final String overview;
  final String? releaseDate;
  final List<int> genreIds;
  final int id;
  final String? originalTitle;
  final String originalLanguage;
  final String title;
  final String backdropPath;
  final double popularity;
  final int voteCount;
  final bool? video;
  final double voteAverage;
}
