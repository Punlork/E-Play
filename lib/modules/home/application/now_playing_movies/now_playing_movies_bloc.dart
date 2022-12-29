import 'dart:async';
import 'package:e_book_app/index.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  NowPlayingMoviesBloc(this.repository) : super(NowPlayingMoviesInitial()) {
    on<OnGetNowPlayingMovies>(_onGetNowPlayingMovies);
    on<OnGetNowPlayingMoviesPaginate>(_onGetNowPlayingMoviesPaginate);
  }

  final MovieRepository repository;
  final List<NowPlayMoviesModelResults> _listNowPlaying = [];

  Future<FutureOr<void>> _onGetNowPlayingMovies(
    OnGetNowPlayingMovies event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    emit(NowPlayingMoviesLoading());
    final result = await repository.getNowPlayingMovies();
    result.fold(
      (l) => emit(NowPlayingMoviesFailed(l)),
      (r) {
        _listNowPlaying.addAll(r.results);
        emit(
          NowPlayingMoviesLoaded(
            nowPlayingMovies: _listNowPlaying,
          ),
        );
      },
    );
  }

  Future<FutureOr<void>> _onGetNowPlayingMoviesPaginate(
    OnGetNowPlayingMoviesPaginate event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    final stateLoaded = state as NowPlayingMoviesLoaded;
    emit(stateLoaded.copyWith(status: PaginateStatus.loading));
    final result = await repository.getNowPlayingMovies(
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(stateLoaded.copyWith(status: PaginateStatus.failed)),
      (r) {
        if (r.results.isNotEmpty) {
          _listNowPlaying.addAll(r.results);
          emit(
            stateLoaded.copyWith(
              status: PaginateStatus.loaded,
              nowPlayingMovies: _listNowPlaying,
              hasReachLimit: false,
            ),
          );
        } else {
          emit(stateLoaded.copyWith(
            status: PaginateStatus.empty,
            hasReachLimit: true,
          ));
        }
      },
    );
  }
}
