import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/home/domain/tv_shows/tv_show_reviews_model.dart';

class TVShowsService {
  TVShowsService(this._dio);

  final Dio _dio;

  Future<PopularTVShowModel> getPopularTvShows(String pageNumber) async {
    final response = await _dio.get<dynamic>(
      AppData.getTVPopularMovies(pageNumber: pageNumber),
    );
    return PopularTVShowModel.fromJson(response.data);
  }

  Future<TvShowDetailModel> getTvShowDetail(int tvShowId) async {
    final response = await _dio.get<dynamic>(
      AppData.getTvShowDetail(tvShowId: tvShowId),
    );
    return TvShowDetailModel.fromJson(response.data);
  }

  Future<GetTvShowVideo> getTvShowVideo(int tvShowId) async {
    final response = await _dio.get<dynamic>(
      AppData.getTvShowVideos(tvShowId: tvShowId),
    );
    return GetTvShowVideo.fromJson(response.data);
  }

  Future<TvShowSuggestion> getTvShowSuggestion({
    required int tvShowId,
    required int pageNumber,
  }) async {
    final response = await _dio.get<dynamic>(
      AppData.getTvShowSuggestion(
        tvShowId: tvShowId,
        pageNumber: pageNumber,
      ),
    );
    return TvShowSuggestion.fromJson(response.data);
  }

  Future<TopRatedTvShow> getTopRatedTvShow(int pageNumber) async {
    final response = await _dio.get<dynamic>(
      AppData.getTopRatedTvShow(pageNumber: pageNumber),
    );
    return TopRatedTvShow.fromJson(response.data);
  }

  Future<TvShowReviews> getTvShowReviews({
    required int pageNumber,
    required int tvShowId,
  }) async {
    final response = await _dio.get<dynamic>(
      AppData.getTvShowReviews(
        pageNumber: pageNumber,
        tvShowId: tvShowId,
      ),
    );
    return TvShowReviews.fromJson(response.data);
  }
}
