part of 'tv_show_suggestion_bloc.dart';

abstract class TvShowSuggestionEvent extends Equatable {
  const TvShowSuggestionEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvShowSuggestion extends TvShowSuggestionEvent {
  const OnGetTvShowSuggestion({
    required this.showId,
    required this.pageNumber,
  });

  final int showId;
  final int pageNumber;
}
