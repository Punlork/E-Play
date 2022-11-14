import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book_app/modules/home/domain/movie_model.dart';
import 'package:e_book_app/modules/home/infrastructure/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(MovieRepository repository)
      : _repository = repository,
        super(MovieInitial()) {
    on<OnGetMovies>(_onGetMovies);
    on<OnGetMoviesNextPage>(_onGetMoviesNextPage);
  }

  final MovieRepository _repository;
  final movies = <Movies>[];

  Future<FutureOr<void>> _onGetMovies(
    OnGetMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    final result = await _repository.getMovieList();
    result.fold(
      (l) => emit(MovieFailed(l)),
      (r) => {
        movies.addAll(r.movies),
        emit(MovieLoaded(movie: movies, pageNumber: r.pageNumber)),
      },
    );
  }

  Future<FutureOr<void>> _onGetMoviesNextPage(
    OnGetMoviesNextPage event,
    Emitter<MovieState> emit,
  ) async {
    emit((state as MovieLoaded).copyWith(status: MovieStatus.loading));
    final result = await _repository.getMovieList(
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(
        (state as MovieLoaded).copyWith(
          status: MovieStatus.ended,
        ),
      ),
      (r) => {
        movies.addAll(r.movies),
        emit(
          (state as MovieLoaded).copyWith(
            status: MovieStatus.loaded,
            nextMovies: movies,
          ),
        )
      },
    );
  }
}
