import 'dart:async';
import 'package:e_book_app/index.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc(MovieRepository repository)
      : _repository = repository,
        super(PopularMoviesInitial()) {
    on<OnGetPopularMovies>(_onGetPopularMovies);
    on<OnGetPopularMoviesNext>(_onGetPopularMoviesNext);
  }

  final MovieRepository _repository;

  final _popularMovies = <PopularMoviesData>[];

  Future<FutureOr<void>> _onGetPopularMovies(
    OnGetPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());
    final result = await _repository.getPopularMovies();
    result.fold(
      (l) => emit(PopularMoviesFailure(l)),
      (r) => {
        _popularMovies.addAll(r),
        emit(PopularMoviesLoaded(popularMovies: _popularMovies)),
      },
    );
  }

  Future<FutureOr<void>> _onGetPopularMoviesNext(
    OnGetPopularMoviesNext event,
    Emitter<PopularMoviesState> emit,
  ) async {
    final stateLoaded = state as PopularMoviesLoaded;
    emit(stateLoaded.copyWith(status: PaginateStatus.loading));
    final result = await _repository.getPopularMovies(
      pageNumber: event.pageNumber,
    );
    emit(
      result.fold(
        (l) => stateLoaded.copyWith(status: PaginateStatus.failed),
        (r) {
          if (r.isNotEmpty) {
            _popularMovies.addAll(r);
            return stateLoaded.copyWith(
              popularMovies: _popularMovies,
              hasReachLimit: false,
              status: PaginateStatus.loaded,
            );
          } else {
            return stateLoaded.copyWith(
              status: PaginateStatus.empty,
              hasReachLimit: true,
            );
          }
        },
      ),
    );
  }
}
