import 'package:e_book_app/index.dart';

class PopularMovieShowAll extends StatelessWidget {
  const PopularMovieShowAll({super.key});

  static const String routeName = 'popular_movie_show_all';
  static const String routePath = '/popular_movie_show_all';

  static final route = GoRoute(
    path: routePath,
    name: routeName,
    builder: (context, state) => const PopularMovieShowAll(),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.popular(pageNumber);
    return ShowAllMovieSeries(
      url: url,
      title: 'Popular Movies',
    );
  }
}
