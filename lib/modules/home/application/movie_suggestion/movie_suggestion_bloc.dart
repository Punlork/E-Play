import 'dart:async';
import 'package:e_book_app/index.dart';

part 'movie_suggestion_event.dart';
part 'movie_suggestion_state.dart';

class MovieSuggestionBloc extends Bloc<MovieSuggestionEvent, MovieSuggestionState> {
  MovieSuggestionBloc(MovieRepository repository)
      : _movieRepository = repository,
        super(MovieSuggestionInitial()) {
    on<OnGetMovieSuggestion>(_onGetMovieSuggestion);
  }

  final MovieRepository _movieRepository;

  Future<FutureOr<void>> _onGetMovieSuggestion(
    OnGetMovieSuggestion event,
    Emitter<MovieSuggestionState> emit,
  ) async {
    emit(MovieSuggestionLoading());
    final result = await _movieRepository.getMovieSuggestion(movieId: event.movieId);
    result.fold(
      (l) => emit(MovieSuggestionFailed(l)),
      (r) => emit(MovieSuggestionLoaded(r)),
    );
  }
}
