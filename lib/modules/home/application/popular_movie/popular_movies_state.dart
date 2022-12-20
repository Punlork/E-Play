part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  const PopularMoviesLoaded(this.popularMovies);

  final List<PopularMoviesData> popularMovies;
}

class PopularMoviesFailure extends PopularMoviesState {
  const PopularMoviesFailure(this.message);

  final String message;
}
