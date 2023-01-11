import 'dart:developer';

import 'package:e_book_app/index.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movieId});

  final String movieId;

  static const String routeName = 'movie_detail_page';
  static const String routePath = '/movie_detail_page';

  static final route = GoRoute(
    name: routeName,
    path: routePath,
    builder: (context, state) => MovieDetailPage(
      movieId: state.queryParams['movie_id'] ?? '',
    ),
    pageBuilder: (context, state) => AppRouteTransition(
      context: context,
      state: state,
      child: MovieDetailPage(
        movieId: state.queryParams['movie_id'] ?? '',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final url = AppData.getMovieDetail(int.parse(movieId));
    final suggestionUrl = AppData.getMovieSuggestion(movieId: movieId);
    final reviewUrl = AppData.getMovieReviews(movieId: movieId);
    final videoUrl = AppData.getVideoInfo(movieId: movieId);
    return HomeDetailPage(
      url: url,
      type: DetailType.movie,
      reviewUrl: reviewUrl,
      suggestionUrl: suggestionUrl,
      videoUrl: videoUrl,
      onPressed: (id) => GoRouter.of(context).pushNamed(
        MovieDetailPage.routeName,
        queryParams: {'movie_id': id},
      ),
    );
  }
}
