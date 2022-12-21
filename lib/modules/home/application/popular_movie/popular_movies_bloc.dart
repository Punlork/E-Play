import 'dart:async';
import 'package:e_book_app/index.dart';

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
