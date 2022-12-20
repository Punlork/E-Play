import 'package:dartz/dartz.dart';
import 'package:e_book_app/modules/index.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResModelData>> getMovieList({int pageNumber});
  Future<Either<String, MovieDetailResModel>> getMovieDetail({int movieId});
  Future<Either<String, List<MovieSuggestionResults>>> getMovieSuggestion({
    int movieId,
    int pageNumber,
  });
  Future<Either<String, List<PopularMoviesData>>> getPopularMovies({int pageNumber});
  Future<Either<String, UpcomingMoviesModel>> getUpcomingMovies({int pageNumber});
  Future<Either<String, NowPlayMoviesModel>> getNowPlayingMovies({int pageNumber});
  Future<Either<String, VideoModel>> getVideoInfo({int movieId});
}

class MoviesRepositoryImpl extends MovieRepository {
  MoviesRepositoryImpl(this.service);

  final MovieService service;

  @override
  Future<Either<String, MovieResModelData>> getMovieList({
    int pageNumber = 1,
  }) async {
    try {
      final response = await service.getMovieList(pageNumber: pageNumber);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovieDetailResModel>> getMovieDetail({
    int movieId = 1,
  }) async {
    try {
      final response = await service.getMovieDetail(movieId: movieId);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MovieSuggestionResults>>> getMovieSuggestion({
    int movieId = 1,
    int pageNumber = 1,
  }) async {
    try {
      final response = await service.getMovieSuggestion(
        movieId: movieId,
        pageNumber: pageNumber,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PopularMoviesData>>> getPopularMovies({int pageNumber = 1}) async {
    try {
      final response = await service.getPopularMovie(pageNumber);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UpcomingMoviesModel>> getUpcomingMovies({int pageNumber = 1}) async {
    try {
      final response = await service.getUpcomingMovies(pageNumber);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, NowPlayMoviesModel>> getNowPlayingMovies({int pageNumber = 1}) async {
    try {
      final response = await service.getPlayingNowMovies(pageNumber);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, VideoModel>> getVideoInfo({int movieId = 1}) async {
    try {
      final response = await service.getVideoInfo(movieId: movieId);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
