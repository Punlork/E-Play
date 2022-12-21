import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/home/application/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:e_book_app/modules/home/application/tv_show_video/tv_show_video_bloc.dart';

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
    ..registerFactory<TvShowVideoBloc>(() => TvShowVideoBloc(getIt()));
}
