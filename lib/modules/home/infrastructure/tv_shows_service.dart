import 'package:e_book_app/index.dart';

class TVShowsService {
  TVShowsService(this._dio);

  final Dio _dio;

  Future<PopularTVShowModel> getPopularTvShows(String pageNumber) async {
    final response = await _dio.get<dynamic>(
      AppData.getTVPopularMovies(pageNumber: pageNumber),
    );
    return PopularTVShowModel.fromJson(response.data);
  }
}
