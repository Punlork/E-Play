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
    ..registerLazySingleton<ShowAllService>(() => ShowAllService(getIt()))
    ..registerLazySingleton<ShowAllRepository>(
      () => ShowAllRepositoryImpl(getIt()),
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
    ..registerFactory<TvShowSuggestionBloc>(() => TvShowSuggestionBloc(getIt()))
    ..registerFactory<TopRatedMoviesBloc>(() => TopRatedMoviesBloc(getIt()))
    ..registerFactory<TopRatedTvShowBloc>(() => TopRatedTvShowBloc(getIt()))
    ..registerFactory<MovieReviewsBloc>(() => MovieReviewsBloc(getIt()))
    ..registerFactory<TvShowReviewsBloc>(() => TvShowReviewsBloc(getIt()))
    ..registerFactory<ShowAllBloc>(() => ShowAllBloc(getIt()));
}
