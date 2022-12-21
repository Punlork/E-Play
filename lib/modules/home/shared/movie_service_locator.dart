import 'package:e_book_app/index.dart';

void movieServiceLocator() {
  getIt
    ..registerLazySingleton<MovieService>(() => MovieService(getIt()))
    ..registerLazySingleton<MovieRepository>(
      () => MoviesRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<TVShowsService>(() => TVShowsService(getIt()))
    ..registerLazySingleton<TvShowsRepository>(
      () => TvShowsRepositoryImpl(getIt()),
    )
    ..registerFactory<MovieDetailBloc>(() => MovieDetailBloc(getIt()))
    ..registerFactory<MovieSuggestionBloc>(() => MovieSuggestionBloc(getIt()))
    ..registerFactory<PopularMoviesBloc>(() => PopularMoviesBloc(getIt()))
    ..registerFactory<UpcomingMoviesBloc>(() => UpcomingMoviesBloc(getIt()))
    ..registerFactory<NowPlayingMoviesBloc>(() => NowPlayingMoviesBloc(getIt()))
    ..registerFactory<PopularTvShowsBloc>(() => PopularTvShowsBloc(getIt()))
    ..registerFactory<GetVideoInfoBloc>(() => GetVideoInfoBloc(getIt()))
    ..registerFactory<GetTrendingBloc>(() => GetTrendingBloc(getIt()))
    ..registerFactory<TvShowDetailBloc>(() => TvShowDetailBloc(getIt()))
    ..registerFactory<TvShowVideoBloc>(() => TvShowVideoBloc(getIt()))
    ..registerFactory<TvShowSuggestionBloc>(() => TvShowSuggestionBloc(getIt()));
}
