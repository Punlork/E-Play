import 'dart:async';
import 'package:e_book_app/index.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  NowPlayingMoviesBloc(this.repository) : super(NowPlayingMoviesInitial()) {
    on<OnGetNowPlayingMovies>(_onGetNowPlayingMovies);
  }

  final MovieRepository repository;

  Future<FutureOr<void>> _onGetNowPlayingMovies(
    OnGetNowPlayingMovies event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    emit(NowPlayingMoviesLoading());
    final result = await repository.getNowPlayingMovies(pageNumber: event.pageNumber);
    result.fold(
      (l) => emit(NowPlayingMoviesFailed(l)),
      (r) => emit(NowPlayingMoviesLoaded(r.results)),
    );
  }
}
