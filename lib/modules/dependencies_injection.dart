import 'package:e_book_app/index.dart';

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
      const Duration(milliseconds: 100),
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
