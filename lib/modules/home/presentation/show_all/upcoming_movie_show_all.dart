import 'dart:developer';

import 'package:e_book_app/index.dart';

class UpcomingMovieShowAll extends StatelessWidget {
  const UpcomingMovieShowAll({super.key});

  static const String routeName = 'upcoming_movie_show_all';
  static const String routePath = '/upcoming_movie_show_all';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const UpcomingMovieShowAll(),
    pageBuilder: (context, state) => AppRouteTransition(
      context: context,
      state: state,
      child: const UpcomingMovieShowAll(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getUpcomingMovies;
    return ShowAllMovieSeries(
      type: DetailType.movie,
      url: url,
      title: 'Upcoming Movies',
    );
  }
}
