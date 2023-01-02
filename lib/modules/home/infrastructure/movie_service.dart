import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/home/domain/trending_model.dart';

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
    final response = await service.get<dynamic>(AppData.popular);
    final movies = PopularMovies.fromJson(response.data);
    return movies.results;
  }

  Future<UpcomingMoviesModel> getUpcomingMovies(int pageNumber) async {
    final response = await service.get<dynamic>(AppData.getUpcomingMovies);
    return UpcomingMoviesModel.fromJson(response.data);
  }

  Future<NowPlayMoviesModel> getPlayingNowMovies(int pageNumber) async {
    final response = await service.get<dynamic>(AppData.getNowPlayingMovies);
    return NowPlayMoviesModel.fromJson(response.data);
  }

  Future<TrendingModel> getTrendingMovies(String mediaType) async {
    final response = await service.get<dynamic>(
      AppData.getTrending(mediaType: mediaType),
    );
    return TrendingModel.fromJson(response.data);
  }

  Future<TopRatedMovies> getTopRatedMovies(int pageNumber) async {
    final response = await service.get<dynamic>(AppData.getTopRatedMovies);
    return TopRatedMovies.fromJson(response.data);
  }

  Future<MovieReviews> getMovieReviews({
    required int pageNumber,
    required int movieId,
  }) async {
    final response = await service.get<dynamic>(
      AppData.getMovieReviews(
        pageNumber: pageNumber,
        movieId: movieId,
      ),
    );
    return MovieReviews.fromJson(response.data);
  }
}
