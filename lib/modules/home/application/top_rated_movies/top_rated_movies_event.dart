part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnGetTopRatedMovies extends TopRatedMoviesEvent {
  const OnGetTopRatedMovies(this.pageNumber);

  final int pageNumber;
}
