import 'package:e_book_app/index.dart';

class MovieService {
  MovieService(this.service);

  final Dio service;

  Future<VideoModel> getVideoInfo({required int movieId}) async {
    final response = await service.get<dynamic>(
      AppData.getVideoInfo(
        movieId: movieId,
      ),
    );
    return VideoModel.fromJson(response.data);
  }

  Future<MovieResModelData> getMovieList({required int pageNumber}) async {
    final response = await service.get<dynamic>(
      '${AppData.listMovie}?page=$pageNumber',
    );
    final movie = MovieResModel.fromJson(response.data);

    return movie.data;
  }

  Future<MovieDetailResModel> getMovieDetail({required int movieId}) async {
    final response = await service.get<dynamic>(AppData.getMovieDetail(movieId.toString()));
    final movie = MovieDetailResModel.fromJson(response.data);
    return movie;
  }

  Future<List<MovieSuggestionResults>> getMovieSuggestion({
    required int movieId,
    required int pageNumber,
  }) async {
    final response = await service.get<dynamic>(
      AppData.getMovieSuggestion(
        movieId: movieId.toString(),
        pageNumber: pageNumber.toString(),
      ),
    );
    final movie = MovieSuggestion.fromJson(response.data);
    return movie.results;
  }

  Future<List<PopularMoviesData>> getPopularMovie(int pageNumber) async {
    final response = await service.get<dynamic>(AppData.popular(pageNumber.toString()));
    final movies = PopularMovies.fromJson(response.data);
    return movies.results;
  }

  Future<UpcomingMoviesModel> getUpcomingMovies(int pageNumber) async {
    final response = await service.get<dynamic>(
      AppData.getUpcomingMovies(
        pageNumber: pageNumber.toString(),
      ),
    );
    return UpcomingMoviesModel.fromJson(response.data);
  }

  Future<NowPlayMoviesModel> getPlayingNowMovies(int pageNumber) async {
    final response = await service.get<dynamic>(
      AppData.getNowPlayingMovies(
        pageNumber: pageNumber.toString(),
      ),
    );
    // log(response.data);
    return NowPlayMoviesModel.fromJson(response.data);
  }
}
