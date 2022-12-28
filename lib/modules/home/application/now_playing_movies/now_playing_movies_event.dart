part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnGetNowPlayingMovies extends NowPlayingMoviesEvent {
  const OnGetNowPlayingMovies();
}

class OnGetNowPlayingMoviesPaginate extends NowPlayingMoviesEvent {
  const OnGetNowPlayingMoviesPaginate(this.pageNumber);

  final int pageNumber;
}
