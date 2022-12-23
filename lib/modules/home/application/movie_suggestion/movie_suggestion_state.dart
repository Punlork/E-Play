part of 'movie_suggestion_bloc.dart';



abstract class MovieSuggestionState extends Equatable {
  const MovieSuggestionState();

  @override
  List<Object> get props => [];
}

class MovieSuggestionInitial extends MovieSuggestionState {}

class MovieSuggestionLoading extends MovieSuggestionState {}

class MovieSuggestionLoaded extends MovieSuggestionState {
  const MovieSuggestionLoaded(
    this.movieSuggestion, {
    this.status = PaginateStatus.initial,
  });

  final List<MovieSuggestionResults> movieSuggestion;
  final PaginateStatus status;

  MovieSuggestionLoaded copyWith({
    PaginateStatus? status,
    List<MovieSuggestionResults>? movieSuggestion,
  }) {
    return MovieSuggestionLoaded(
      movieSuggestion ?? this.movieSuggestion,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, movieSuggestion];
}

class MovieSuggestionFailed extends MovieSuggestionState {
  const MovieSuggestionFailed(this.message);

  final String message;
}
