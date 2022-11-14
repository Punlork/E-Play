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
