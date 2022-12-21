class AppData {
  AppData._();

  static const String somethingWentWrong = 'Something went wrong';

  static const String apiKey = '022cb7dedba411c017779a0bbf531c69';
  static const String mainUrl = 'https://api.themoviedb.org/3/movie';
  static const String mainUrlTV = 'https://api.themoviedb.org/3/tv';
  static const String mainUrlTrending = 'https://api.themoviedb.org/3/trending';
  static const String suggestionMovie = '$mainUrl/movie_suggestions.json';
  static const String listMovie = '$mainUrl/list_movies.json';
  static const String movieDetail = '$mainUrl/movie_details.json';
  static const String latestMovie = '$mainUrl/latest?api_key=$apiKey&language=en-US';
  static const String ytTrailerCode = 'https://youtu.be/';

  static String getVideoInfo({
    required int movieId,
  }) =>
      '$mainUrl/$movieId/videos?api_key=$apiKey&language=en-US';

  static dynamic popular(String pageNumber) =>
      '$mainUrl/popular?api_key=$apiKey&language=en-US&page=$pageNumber';

  static dynamic getTrending({required String mediaType}) =>
      '$mainUrlTrending/$mediaType/week?api_key=$apiKey';

  static String imagePath({required String posterPath}) =>
      'https://image.tmdb.org/t/p/w500$posterPath';

  static String getMovieDetail(String movieId) =>
      '$mainUrl/$movieId?api_key=$apiKey&language=en-US';

  static String getMovieSuggestion({
    required String movieId,
    required String pageNumber,
  }) =>
      '$mainUrl/$movieId/recommendations?api_key=$apiKey&language=en-US&page=$pageNumber';

  static String getUpcomingMovies({required String pageNumber}) =>
      '$mainUrl/upcoming?api_key=$apiKey&language=en-US&page=$pageNumber';

  static String getNowPlayingMovies({required String pageNumber}) =>
      '$mainUrl/now_playing?api_key=$apiKey&language=en-US&page=$pageNumber';

  static String getTVPopularMovies({required String pageNumber}) =>
      '$mainUrlTV/popular?api_key=$apiKey&language=en-US&&page=$pageNumber';

  static const String getLatestMovies = '$mainUrl/latest?api_key=$apiKey&language=en-US';
}
