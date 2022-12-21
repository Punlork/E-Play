import 'dart:async';
import 'package:e_book_app/index.dart';

part 'tv_show_suggestion_event.dart';
part 'tv_show_suggestion_state.dart';

class TvShowSuggestionBloc extends Bloc<TvShowSuggestionEvent, TvShowSuggestionState> {
  TvShowSuggestionBloc(this.repository) : super(TvShowSuggestionInitial()) {
    on<OnGetTvShowSuggestion>(_onGetTvShowSuggestion);
  }

  final TvShowsRepository repository;

  Future<FutureOr<void>> _onGetTvShowSuggestion(
    OnGetTvShowSuggestion event,
    Emitter<TvShowSuggestionState> emit,
  ) async {
    emit(TvShowSuggestionLoading());
    final result = await repository.getTvShowSuggestion(
      pageNumber: event.pageNumber,
      tvShowId: event.showId,
    );
    result.fold(
      (l) => emit(TvShowSuggestionFailed(l)),
      (r) => emit(TvShowSuggestionLoaded(r.results)),
    );
  }
}
