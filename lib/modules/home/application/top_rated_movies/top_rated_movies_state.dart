part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesInitial extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesLoaded extends TopRatedMoviesState {
  const TopRatedMoviesLoaded(this.topRatedMovies);

  final List<TopRatedMoviesResults> topRatedMovies;
}

class TopRatedMoviesFailed extends TopRatedMoviesState {
  const TopRatedMoviesFailed(this.message);

  final String message;
}
