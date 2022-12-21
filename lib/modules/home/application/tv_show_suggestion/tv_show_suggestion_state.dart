part of 'tv_show_suggestion_bloc.dart';

abstract class TvShowSuggestionState extends Equatable {
  const TvShowSuggestionState();

  @override
  List<Object> get props => [];
}

class TvShowSuggestionInitial extends TvShowSuggestionState {}

class TvShowSuggestionLoading extends TvShowSuggestionState {}

class TvShowSuggestionLoaded extends TvShowSuggestionState {
  const TvShowSuggestionLoaded(this.tvShowSuggestions);

  final List<TvShowSuggestionResults> tvShowSuggestions;
}

class TvShowSuggestionFailed extends TvShowSuggestionState {
  const TvShowSuggestionFailed(this.message);

  final String message;
}
