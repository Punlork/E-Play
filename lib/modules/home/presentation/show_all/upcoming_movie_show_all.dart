import 'package:e_book_app/index.dart';

int pageNumber = 1;

class UpcomingMovieShowAll extends StatelessWidget {
  const UpcomingMovieShowAll({super.key});

  static const String routeName = 'upcoming_movie_show_all';
  static const String routePath = '/upcoming_movie_show_all';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const UpcomingMovieShowAll(),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getUpcomingMovies(pageNumber: pageNumber);
    return ShowAllMovieSeries(
      url: url,
      title: 'Upcoming Movies',
    );
  }
}
