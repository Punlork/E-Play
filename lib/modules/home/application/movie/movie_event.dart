part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object?> get props => [];
}

class OnGetMovies extends MovieEvent {}

class OnGetMoviesNextPage extends MovieEvent {
  const OnGetMoviesNextPage({
    this.pageNumber = 1,
  });

  final int pageNumber;
}
