import 'package:dartz/dartz.dart';
import 'package:e_book_app/index.dart';

abstract class TvShowsRepository {
  Future<Either<String, PopularTVShowModel>> getPopularTvShows({int pageNumber});
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
}
