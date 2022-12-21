import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/home/application/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:e_book_app/modules/home/application/tv_show_video/tv_show_video_bloc.dart';

List<BlocProvider> movieBlocProvider = [
  // BlocProvider<MovieBloc>(
  //   create: (context) => getIt<MovieBloc>(),
  // ),
  BlocProvider<MovieDetailBloc>(
    create: (context) => getIt<MovieDetailBloc>(),
  ),
  BlocProvider<MovieSuggestionBloc>(
    create: (context) => getIt<MovieSuggestionBloc>(),
  ),
  BlocProvider<PopularMoviesBloc>(
    create: (context) => getIt<PopularMoviesBloc>(),
  ),
  BlocProvider<UpcomingMoviesBloc>(
    create: (context) => getIt<UpcomingMoviesBloc>(),
  ),
  BlocProvider<NowPlayingMoviesBloc>(
    create: (context) => getIt<NowPlayingMoviesBloc>(),
  ),
  BlocProvider<PopularTvShowsBloc>(
    create: (context) => getIt<PopularTvShowsBloc>(),
  ),
  BlocProvider<GetVideoInfoBloc>(
    create: (context) => getIt<GetVideoInfoBloc>(),
  ),
  BlocProvider<GetTrendingBloc>(
    create: (context) => getIt<GetTrendingBloc>(),
  ),
  BlocProvider<TvShowDetailBloc>(
    create: (context) => getIt<TvShowDetailBloc>(),
  ),
  BlocProvider<TvShowVideoBloc>(
    create: (context) => getIt<TvShowVideoBloc>(),
  ),
];
