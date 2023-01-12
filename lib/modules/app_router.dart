import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/setting/presentation/settings_page.dart';

final appRouter = GoRouter(
  initialLocation: MainPage.routePath,
  routes: [
    MainPage.route,
    HomePage.route,
    MovieDetailPage.route,
    SeriesDetailPage.route,
    HomeDetailPage.route,
    ShowAllMovieSeries.route,
    SettingsPage.route,
    HomeTvShowDetailPage.route,
    UpcomingMovieShowAll.route,
    PopularMovieShowAll.route,
    NowPlayingMovieShowAll.route,
    PopularSeriesShowAll.route,
    TopRatedMovieShowAll.route,
    TopRatedSeriesShowAll.route,
    FullScreenImage.route,
    ProfilePage.route,
  ],
);
