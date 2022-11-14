import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book_app/modules/home/domain/movie_detail_model.dart';
import 'package:e_book_app/modules/home/infrastructure/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(MovieRepository repository)
      : _repository = repository,
        super(MovieDetailInitial()) {
    on<OnGetMovieDetail>(_onGetMovieDetail);
  }

  final MovieRepository _repository;

  Future<FutureOr<void>> _onGetMovieDetail(
    OnGetMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    final movie = <MovieDetailResModelData>[];
    emit(MovieDetailLoading());
    final result = await _repository.getMovieDetail(movieId: event.movieId ?? 1);
    result.fold(
      (l) => emit(MovieDetailFailed(l)),
      (r) => {emit(MovieDetailLoaded(r))},
    );
  }
}
