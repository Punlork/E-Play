import 'package:e_book_app/index.dart';

class TopRatedMovieShowAll extends StatelessWidget {
  const TopRatedMovieShowAll({super.key});

  static const String routeName = 'top_rated_movies_show_all';
  static const String routePath = '/top_rated_movies_show_all';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const TopRatedMovieShowAll(),
    pageBuilder: (context, state) => AppRouteTransition(
      context: context,
      state: state,
      child: const TopRatedMovieShowAll(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getTopRatedMovies;
    return ShowAllMovieSeries(
      type: DetailType.movie,
      title: 'Top Rated Movies',
      url: url,
    );
  }
}
