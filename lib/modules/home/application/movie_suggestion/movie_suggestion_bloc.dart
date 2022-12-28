import 'dart:async';
import 'package:e_book_app/index.dart';

part 'movie_suggestion_event.dart';
part 'movie_suggestion_state.dart';

class MovieSuggestionBloc extends Bloc<MovieSuggestionEvent, MovieSuggestionState> {
  MovieSuggestionBloc(MovieRepository repository)
      : _movieRepository = repository,
        super(MovieSuggestionInitial()) {
    on<OnGetMovieSuggestion>(_onGetMovieSuggestion);
    on<OnGetMovieSuggestionNext>(_onGetMovieSuggestionNext);
    on<OnGetMovieSuggestionClear>(_onGetMovieSuggestionClear);
  }

  final MovieRepository _movieRepository;

  final List<MovieSuggestionResults> _suggestionMovies = [];

  Future<FutureOr<void>> _onGetMovieSuggestion(
    OnGetMovieSuggestion event,
    Emitter<MovieSuggestionState> emit,
  ) async {
    emit(MovieSuggestionLoading());
    final result = await _movieRepository.getMovieSuggestion(movieId: event.movieId);
    result.fold(
      (l) => emit(MovieSuggestionFailed(l)),
      (r) => {
        _suggestionMovies.addAll(r),
        emit(MovieSuggestionLoaded(_suggestionMovies)),
      },
    );
  }

  Future<FutureOr<void>> _onGetMovieSuggestionNext(
    OnGetMovieSuggestionNext event,
    Emitter<MovieSuggestionState> emit,
  ) async {
    final stateLoaded = state as MovieSuggestionLoaded;
    emit(stateLoaded.copyWith(status: PaginateStatus.loading));
    final result = await _movieRepository.getMovieSuggestion(
      movieId: event.movieId,
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(stateLoaded.copyWith(status: PaginateStatus.failed)),
      (r) {
        if (r.isNotEmpty) {
          _suggestionMovies.addAll(r);
          emit(
            stateLoaded.copyWith(
              status: PaginateStatus.loaded,
              hasReachLimit: false,
              movieSuggestion: _suggestionMovies,
            ),
          );
        } else {
          emit(
            stateLoaded.copyWith(
              status: PaginateStatus.empty,
              hasReachLimit: true,
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onGetMovieSuggestionClear(
    OnGetMovieSuggestionClear event,
    Emitter<MovieSuggestionState> emit,
  ) {
    _suggestionMovies.clear();
  }
}
