import 'dart:async';
import 'package:e_book_app/index.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  UpcomingMoviesBloc(this.repository) : super(UpcomingMoviesInitial()) {
    on<OnGetUpcomingMovies>(_onGetUpcomingMovies);
  }

  final MovieRepository repository;

  Future<FutureOr<void>> _onGetUpcomingMovies(
    OnGetUpcomingMovies event,
    Emitter<UpcomingMoviesState> emit,
  ) async {
    emit(UpcomingMoviesLoading());
    final result = await repository.getUpcomingMovies(
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(UpcomingMoviesFailed()),
      (r) => emit(UpcomingMoviesLoaded(r.results)),
    );
  }
}
