part of 'movie_suggestion_bloc.dart';

abstract class MovieSuggestionState extends Equatable {
  const MovieSuggestionState();

  @override
  List<Object> get props => [];
}

class MovieSuggestionInitial extends MovieSuggestionState {}

class MovieSuggestionLoading extends MovieSuggestionState {}

class MovieSuggestionLoaded extends MovieSuggestionState {
  const MovieSuggestionLoaded(this.movieSuggestion);

  final MovieSuggestionResModelData movieSuggestion;
}

class MovieSuggestionFailed extends MovieSuggestionState {
  const MovieSuggestionFailed(this.message);

  final String message;
}
