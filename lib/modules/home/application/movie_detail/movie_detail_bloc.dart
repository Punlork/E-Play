import 'dart:async';

import 'package:e_book_app/index.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(MovieRepository repository)
      : _repository = repository,
        super(MovieDetailInitial()) {
    on<OnGetMovieDetail>(_onGetMovieDetail);
    on<OnRemoveMovieDetail>(_onRemoveMovieDetail);
    // on<>
  }

  final MovieRepository _repository;
  final List<MovieDetailResModel> _listMovie = [];
  final List<int> _movieIndexes = [];

  Future<FutureOr<void>> _onGetMovieDetail(
    OnGetMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    _movieIndexes.add(event.id);
    final result = await _repository.getMovieDetail(
      movieId: _movieIndexes.last,
    );
    result.fold(
      (l) => emit(MovieDetailFailed(l)),
      (r) => {
        _listMovie.add(r),
        emit(MovieDetailLoaded(_listMovie)),
      },
    );
  }

  FutureOr<void> _onRemoveMovieDetail(
    OnRemoveMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) {
    emit(MovieDetailLoading());
    try {
      _movieIndexes.removeLast();
      _listMovie.removeLast();
      emit(MovieDetailLoaded(_listMovie));
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }
}
