import 'package:dio/dio.dart';
import 'package:e_book_app/modules/app/shared/theme_service_locator.dart';
import 'package:e_book_app/modules/home/shared/movie_service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton<Dio>(Dio.new);

  // ignore: cascade_invocations
  getIt.registerSingletonAsync<DemoService>(
    () async => DemoService().init(),
  );

  appServiceLocator();
  movieServiceLocator();
}

class DemoService {
  Future<DemoService> init() async {
    return Future.delayed(
      const Duration(),
      () {
        prints();
        return this;
      },
    );
  }

  void prints() {
    print('Demo service is ready');
  }
}
