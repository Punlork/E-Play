import 'package:e_book_app/index.dart';

class SeriesDetailPage extends StatelessWidget {
  const SeriesDetailPage({super.key, required this.tvShowId});

  static const String routeName = 'series_detail_page';
  static const String routePath = '/series_detail_page';

  final String tvShowId;

  static final route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => SeriesDetailPage(
      tvShowId: state.queryParams['tv_show_id'] ?? '',
    ),
    pageBuilder: (context, state) => AppRouteTransition<SeriesDetailPage>(
      context: context,
      state: state,
      child: SeriesDetailPage(
        tvShowId: state.queryParams['tv_show_id'] ?? '',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getTvShowDetail(tvShowId: tvShowId);
    final suggestionUrl = AppData.getTvShowSuggestion(tvShowId: tvShowId);
    final reviewUrl = AppData.getTvShowReviews(tvShowId: tvShowId);
    final videoUrl = AppData.getVideoInfo(movieId: tvShowId);
    return HomeDetailPage(
      url: url,
      suggestionUrl: suggestionUrl,
      reviewUrl: reviewUrl,
      videoUrl: videoUrl,
      onPressed: (id) => GoRouter.of(context).pushNamed(
        SeriesDetailPage.routeName,
        queryParams: {'tv_show_id': id},
      ),
    );
  }
}
