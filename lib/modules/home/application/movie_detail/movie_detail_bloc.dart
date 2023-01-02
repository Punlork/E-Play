import 'dart:async';
import 'dart:developer';

import 'package:e_book_app/index.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(MovieRepository repository)
      : _repository = repository,
        super(MovieDetailInitial()) {
    on<OnGetMovieDetail>(_onGetMovieDetail);
    on<OnRemoveMovieDetail>(_onRemoveMovieDetail);
  }

  final MovieRepository _repository;
  final List<MovieAndSeriesDetailResModel> _listMovie = [];

  Future<FutureOr<void>> _onGetMovieDetail(
    OnGetMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    final result = await _repository.getMovieDetail(url: event.url);
    result.fold(
      (l) => emit(MovieDetailFailed(l)),
      (r) => {
        _listMovie.add(r),
        emit(MovieDetailLoaded(_listMovie.last)),
      },
    );
    // log(_listMovie.last.title);
    // log(_listMovie.length.toString());
  }

  FutureOr<void> _onRemoveMovieDetail(
    OnRemoveMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) {
    if (_listMovie.length > 1) {
      emit(MovieDetailLoading());
      _listMovie.removeLast();
      emit(MovieDetailLoaded(_listMovie.last));
      // log(_listMovie.last.title);
    }
    // log(_listMovie.length.toString());
  }
}
