import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book_app/modules/home/domain/popular_movies_model.dart';
import 'package:e_book_app/modules/home/infrastructure/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc(MovieRepository repository)
      : _repository = repository,
        super(PopularMoviesInitial()) {
    on<OnGetPopularMovies>(_onGetPopularMovies);
  }

  final MovieRepository _repository;

  Future<FutureOr<void>> _onGetPopularMovies(
    OnGetPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());
    final result = await _repository.getPopularMovies();
    result.fold(
      (l) => emit(PopularMoviesFailure(l)),
      (r) => emit(PopularMoviesLoaded(r)),
    );
  }
}
