part of 'movie_suggestion_bloc.dart';

abstract class MovieSuggestionEvent extends Equatable {
  const MovieSuggestionEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieSuggestion extends MovieSuggestionEvent {
  const OnGetMovieSuggestion(this.movieId);

  final int movieId;
}

class OnGetMovieSuggestionNext extends MovieSuggestionEvent {
  const OnGetMovieSuggestionNext({
    required this.movieId,
    required this.pageNumber,
  });

  final int movieId;
  final int pageNumber;
}

class OnGetMovieSuggestionClear extends MovieSuggestionEvent {}
