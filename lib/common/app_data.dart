class AppData {
  AppData._();
  static const String mainUrl = 'https://api.themoviedb.org/3/movie';
  static const String mainUrlTV = 'https://api.themoviedb.org/3/tv';
  static const String mainUrlTrending = 'https://api.themoviedb.org/3/trending';

  static const String somethingWentWrong = 'Something went wrong';

  static const String apiKey = '022cb7dedba411c017779a0bbf531c69';
  static const String suggestionMovie = '$mainUrl/movie_suggestions.json';
  static const String listMovie = '$mainUrl/list_movies.json';
  static const String movieDetail = '$mainUrl/movie_details.json';
  static const String latestMovie = '$mainUrl/latest?api_key=$apiKey&language=en-US';
  static const String ytTrailerCode = 'https://youtu.be/';

  static String getVideoInfo({
    required String movieId,
  }) =>
      '$mainUrl/$movieId/videos?api_key=$apiKey&language=en-US';

  static String get popular => '$mainUrl/popular?api_key=$apiKey&language=en-US&page=';

  static dynamic getTrending({required String mediaType}) =>
      '$mainUrlTrending/$mediaType/week?api_key=$apiKey';

  static String imagePath({required String posterPath}) =>
      'https://image.tmdb.org/t/p/w500$posterPath';

  static String getMovieDetail(int movieId) => '$mainUrl/$movieId?api_key=$apiKey&language=en-US';

  static String getMovieSuggestion({
    required String movieId,
  }) =>
      '$mainUrl/$movieId/recommendations?api_key=$apiKey&language=en-US&page=';

  static String get getUpcomingMovies => '$mainUrl/upcoming?api_key=$apiKey&language=en-US&page=';

  static String get getTopRatedMovies => '$mainUrl/top_rated?api_key=$apiKey&language=en-US&page=';

  static String getMovieReviews({required String movieId}) =>
      '$mainUrl/$movieId/reviews?api_key=$apiKey&language=en-US&page=';

  static String get getNowPlayingMovies =>
      '$mainUrl/now_playing?api_key=$apiKey&language=en-US&page=';

  static String get getTVPopularMovies => '$mainUrlTV/popular?api_key=$apiKey&language=en-US&page=';

  static String getTvShowDetail({required String tvShowId}) =>
      '$mainUrlTV/$tvShowId?api_key=$apiKey&language=en-US';

  static String getTvShowVideos({required int tvShowId}) =>
      '$mainUrlTV/$tvShowId/videos?api_key=$apiKey&language=en-US';

  static String getTvShowReviews({required String tvShowId}) =>
      '$mainUrlTV/$tvShowId/reviews?api_key=$apiKey&language=en-US&page=';

  static String get getTopRatedTvShow =>
      '$mainUrlTV/top_rated?api_key=$apiKey&language=en-US&page=';

  static String getTvShowSuggestion({required String tvShowId}) =>
      '$mainUrlTV/$tvShowId/recommendations?api_key=$apiKey&language=en-US&page=';

  static const String getLatestMovies = '$mainUrl/latest?api_key=$apiKey&language=en-US';
}
