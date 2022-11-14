import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book_app/modules/home/domain/movie_suggestion_model.dart';
import 'package:e_book_app/modules/home/infrastructure/movie_repository.dart';
import 'package:equatable/equatable.dart';

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
