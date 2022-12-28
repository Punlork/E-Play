part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  const NowPlayingMoviesLoaded({
    this.nowPlayingMovies = const [],
    this.status = PaginateStatus.initial,
  });

  final List<NowPlayMoviesModelResults> nowPlayingMovies;
  final PaginateStatus status;

  NowPlayingMoviesLoaded copyWith({
    List<NowPlayMoviesModelResults>? nowPlayingMovies,
    PaginateStatus? status,
  }) {
    return NowPlayingMoviesLoaded(
      status: status ?? this.status,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
    );
  }

  @override
  List<Object> get props => [status];
}

class NowPlayingMoviesFailed extends NowPlayingMoviesState {
  const NowPlayingMoviesFailed(this.message);

  final String message;
}
