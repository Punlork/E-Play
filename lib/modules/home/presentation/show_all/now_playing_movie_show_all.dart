import 'package:e_book_app/index.dart';

class NowPlayingMovieShowAll extends StatelessWidget {
  const NowPlayingMovieShowAll({super.key});

  static const String routeName = 'now_playing_movie_show_all';
  static const String routePath = '/now_playing_movie_show_all';

  static final route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => const NowPlayingMovieShowAll(),
    pageBuilder: (context, state) => AppRouteTransition(
      context: context,
      state: state,
      child: const NowPlayingMovieShowAll(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getNowPlayingMovies;
    return ShowAllMovieSeries(
      title: 'In Theater',
      url: url,
    );
  }
}
