import 'package:e_book_app/index.dart';

class TVShowsService {
  TVShowsService(this._dio);

  final Dio _dio;

  Future<PopularTVShowModel> getPopularTvShows(String pageNumber) async {
    final response = await _dio.get<dynamic>(AppData.getTVPopularMovies);
    return PopularTVShowModel.fromJson(response.data);
  }

  Future<TvShowDetailModel> getTvShowDetail(int tvShowId) async {
    final response = await _dio.get<dynamic>(AppData.getTvShowDetail(tvShowId: ''));
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
        tvShowId: 'tvShowId',
      ),
    );
    return TvShowSuggestion.fromJson(response.data);
  }

  Future<TopRatedTvShow> getTopRatedTvShow(int pageNumber) async {
    final response = await _dio.get<dynamic>(AppData.getTopRatedTvShow);
    return TopRatedTvShow.fromJson(response.data);
  }

  Future<TvShowReviews> getTvShowReviews({
    required int pageNumber,
    required int tvShowId,
  }) async {
    final response = await _dio.get<dynamic>(
      AppData.getTvShowReviews(tvShowId: 'tvShowId'),
    );
    return TvShowReviews.fromJson(response.data);
  }
}
