import 'package:dartz/dartz.dart';
import 'package:e_book_app/modules/index.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResModelData>> getMovieList({int pageNumber});
  Future<Either<String, MovieAndSeriesDetailResModel>> getMovieDetail({
    String url,
  });
  Future<Either<String, List<MovieSuggestionResults>>> getMovieSuggestion({
    String url,
    int pageNumber,
  });
  Future<Either<String, MovieReviews>> getMovieReviews({
    String url,
    int pageNumber,
  });
  Future<Either<String, List<PopularMoviesData>>> getPopularMovies({int pageNumber});
  Future<Either<String, UpcomingMoviesModel>> getUpcomingMovies({int pageNumber});
  Future<Either<String, NowPlayMoviesModel>> getNowPlayingMovies({int pageNumber});
  Future<Either<String, VideoModel>> getVideoInfo({String url});
  Future<Either<String, TrendingModel>> getTrending({String mediaType});
  Future<Either<String, TopRatedMovies>> getTopRatedMovies({int pageNumber});
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
  Future<Either<String, MovieAndSeriesDetailResModel>> getMovieDetail({
    String url = '',
  }) async {
    try {
      final response = await service.getMovieDetail(
        url: url,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MovieSuggestionResults>>> getMovieSuggestion({
    String url = '',
    int pageNumber = 1,
  }) async {
    try {
      final response = await service.getMovieSuggestion(
        url: url,
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
  Future<Either<String, VideoModel>> getVideoInfo({String url = ''}) async {
    try {
      final response = await service.getVideoInfo(url: url);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TrendingModel>> getTrending({String mediaType = 'all'}) async {
    try {
      final response = await service.getTrendingMovies(mediaType);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TopRatedMovies>> getTopRatedMovies({int pageNumber = 1}) async {
    try {
      final response = await service.getTopRatedMovies(pageNumber);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MovieReviews>> getMovieReviews({
    String url = '',
    int pageNumber = 1,
  }) async {
    try {
      final response = await service.getMovieReviews(
        pageNumber: pageNumber,
        url: url,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
