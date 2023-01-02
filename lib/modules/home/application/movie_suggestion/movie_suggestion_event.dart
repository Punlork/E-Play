part of 'movie_suggestion_bloc.dart';

abstract class MovieSuggestionEvent extends Equatable {
  const MovieSuggestionEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieSuggestion extends MovieSuggestionEvent {
  const OnGetMovieSuggestion(this.url);

  final String url;
}

class OnGetMovieSuggestionNext extends MovieSuggestionEvent {
  const OnGetMovieSuggestionNext({
    required this.pageNumber,
    required this.url,
  });

  final String url;
  final int pageNumber;
}
