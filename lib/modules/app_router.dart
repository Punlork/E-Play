import 'package:e_book_app/modules/app/index.dart';
import 'package:e_book_app/modules/explore/presentation/explore_detail_page.dart';
import 'package:e_book_app/modules/explore/presentation/explore_page.dart';
import 'package:e_book_app/modules/home/presentation/home_detail_page.dart';
import 'package:e_book_app/modules/home/presentation/home_page.dart';
import 'package:e_book_app/modules/setting/presentation/settings_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: MainPage.routePath,
  routes: [
    MainPage.route,
    HomePage.route,
    HomeDetailPage.route,
    ExplorePage.route,
    ExploreDetailPage.route,
    SettingsPage.route,
  ],
);
