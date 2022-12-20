part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  const NowPlayingMoviesLoaded(this.nowPlayingMovies);

  final List<NowPlayMoviesModelResults> nowPlayingMovies;
}

class NowPlayingMoviesFailed extends NowPlayingMoviesState {
  const NowPlayingMoviesFailed(this.message);

  final String message;
}
