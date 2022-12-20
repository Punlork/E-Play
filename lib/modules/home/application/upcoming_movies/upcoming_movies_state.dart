part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object> get props => [];
}

class UpcomingMoviesInitial extends UpcomingMoviesState {}

class UpcomingMoviesLoading extends UpcomingMoviesState {}

class UpcomingMoviesLoaded extends UpcomingMoviesState {
  const UpcomingMoviesLoaded(this.upComingMovies);

  final List<UpcomingMoviesModelResults> upComingMovies;
}

class UpcomingMoviesFailed extends UpcomingMoviesState {}
