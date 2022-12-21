import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/setting/presentation/settings_page.dart';

final appRouter = GoRouter(
  initialLocation: MainPage.routePath,
  routes: [
    MainPage.route,
    HomePage.route,
    HomeDetailPage.route,
    ExplorePage.route,
    ExploreDetailPage.route,
    SettingsPage.route,
    HomeTvShowDetailPage.route,
  ],
);
