import 'package:dartz/dartz.dart';
import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/home/domain/tv_shows/tv_show_reviews_model.dart';

abstract class TvShowsRepository {
  Future<Either<String, PopularTVShowModel>> getPopularTvShows({int pageNumber});
  Future<Either<String, TvShowDetailModel>> getTvShowDetail({int tvShowId});
  Future<Either<String, GetTvShowVideo>> getTvShowVideo({int tvShowId});
  Future<Either<String, TvShowSuggestion>> getTvShowSuggestion({
    int tvShowId,
    int pageNumber,
  });
  Future<Either<String, TopRatedTvShow>> getTopRatedTvShow({int pageNumber});

  Future<Either<String, TvShowReviews>> getTvShowReviews({
    int tvShowId,
    int pageNumber,
  });
}

class TvShowsRepositoryImpl implements TvShowsRepository {
  TvShowsRepositoryImpl(this.service);

  final TVShowsService service;

  @override
  Future<Either<String, PopularTVShowModel>> getPopularTvShows({
    int pageNumber = 1,
  }) async {
    try {
      final response = await service.getPopularTvShows(pageNumber.toString());
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TvShowDetailModel>> getTvShowDetail({int tvShowId = 1}) async {
    try {
      final response = await service.getTvShowDetail(tvShowId);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, GetTvShowVideo>> getTvShowVideo({int tvShowId = 1}) async {
    try {
      final response = await service.getTvShowVideo(tvShowId);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TvShowSuggestion>> getTvShowSuggestion({
    int tvShowId = 1,
    int pageNumber = 1,
  }) async {
    try {
      final response = await service.getTvShowSuggestion(
        tvShowId: tvShowId,
        pageNumber: pageNumber,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TopRatedTvShow>> getTopRatedTvShow({int pageNumber = 1}) async {
    try {
      final response = await service.getTopRatedTvShow(pageNumber);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TvShowReviews>> getTvShowReviews({
    int tvShowId = 1,
    int pageNumber = 1,
  }) async {
    try {
      final response = await service.getTvShowReviews(
        pageNumber: pageNumber,
        tvShowId: tvShowId,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
