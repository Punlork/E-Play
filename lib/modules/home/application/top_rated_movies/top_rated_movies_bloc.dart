import 'dart:async';
import 'package:e_book_app/index.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc(this.repository) : super(TopRatedMoviesInitial()) {
    on<OnGetTopRatedMovies>(_onGetTopRatedMovies);
  }

  final MovieRepository repository;

  Future<FutureOr<void>> _onGetTopRatedMovies(
    OnGetTopRatedMovies event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(TopRatedMoviesLoading());
    final result = await repository.getTopRatedMovies(pageNumber: event.pageNumber);
    result.fold(
      (l) => emit(TopRatedMoviesFailed(l)),
      (r) => emit(TopRatedMoviesLoaded(r.results)),
    );
  }
}
