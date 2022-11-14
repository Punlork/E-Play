import 'package:dartz/dartz.dart';
import 'package:e_book_app/modules/home/domain/movie_detail_model.dart';
import 'package:e_book_app/modules/home/domain/movie_model.dart';
import 'package:e_book_app/modules/home/domain/movie_suggestion_model.dart';
import 'package:e_book_app/modules/home/infrastructure/movie_service.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResModelData>> getMovieList({int pageNumber});
  Future<Either<String, MovieDetailResModelData>> getMovieDetail({int movieId});
  Future<Either<String, MovieSuggestionResModelData>> getMovieSuggestion({int movieId});
}

class MoviewRepositoryImpl extends MovieRepository {
  MoviewRepositoryImpl(this.service);

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
  Future<Either<String, MovieDetailResModelData>> getMovieDetail({
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
  Future<Either<String, MovieSuggestionResModelData>> getMovieSuggestion({
    int movieId = 1,
  }) async {
    try {
      final response = await service.getMovieSuggestion(movieId: movieId);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
