import 'package:e_book_app/index.dart';

class PopularSeriesShowAll extends StatelessWidget {
  const PopularSeriesShowAll({super.key});

  static const String routeName = 'popular_series_show_all';
  static const String routePath = '/popular_series_show_all';

  static final route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => const PopularSeriesShowAll(),
    pageBuilder: (context, state) => AppRouteTransition(
      context: context,
      state: state,
      child: const PopularSeriesShowAll(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getTVPopularMovies;
    return ShowAllMovieSeries(
      type: DetailType.tvShow,
      title: 'Popular Series',
      url: url,
    );
  }
}
