import 'package:e_book_app/index.dart';

class TopRatedSeriesShowAll extends StatelessWidget {
  const TopRatedSeriesShowAll({super.key});

  static const String routeName = 'top_rated_series_show_all';
  static const String routePath = '/top_rated_series_show_all';

  static final route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => const TopRatedSeriesShowAll(),
    pageBuilder: (context, state) => AppRouteTransition(
      context: context,
      state: state,
      child: const TopRatedSeriesShowAll(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getTopRatedTvShow;
    return ShowAllMovieSeries(
      url: url,
      title: 'Top Rated Series',
    );
  }
}
