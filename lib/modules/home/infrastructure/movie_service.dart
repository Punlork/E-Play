import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_book_app/common/app_data.dart';
import 'package:e_book_app/modules/home/domain/movie_detail_model.dart';
import 'package:e_book_app/modules/home/domain/movie_model.dart';
import 'package:e_book_app/modules/home/domain/movie_suggestion_model.dart';

class MovieService {
  MovieService(this.service);

  final Dio service;

  Future<MovieResModelData> getMovieList({required int pageNumber}) async {
    final response = await service.get<dynamic>(
      '${AppData.listMovie}?page=$pageNumber',
    );
    final movie = MovieResModel.fromJson(response.data);

    return movie.data;
  }

  Future<MovieDetailResModelData> getMovieDetail({required int movieId}) async {
    final response = await service.get<dynamic>(
      '${AppData.movieDetail}?movie_id=$movieId',
    );
    final movie = MovieDetailResModel.fromJson(response.data);
    return movie.data;
  }

  Future<MovieSuggestionResModelData> getMovieSuggestion({required int movieId}) async {
    final response = await service.get<dynamic>(
      '${AppData.suggestionMovie}?movie_id=$movieId',
    );
    final movie = MovieSuggestionResModel.fromJson(response.data);
    return movie.data;
  }
}
