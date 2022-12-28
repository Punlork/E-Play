import 'dart:async';
import 'package:e_book_app/index.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class UpcomingMoviesBloc extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  UpcomingMoviesBloc(this.repository) : super(UpcomingMoviesInitial()) {
    on<OnGetUpcomingMovies>(_onGetUpcomingMovies);
    on<OnGetUpcomingMoviesPaginate>(_onGetUpcomingMoviesPaginate);
  }

  final MovieRepository repository;
  final List<UpcomingMoviesModelResults> _upComingMovies = [];

  Future<FutureOr<void>> _onGetUpcomingMovies(
    OnGetUpcomingMovies event,
    Emitter<UpcomingMoviesState> emit,
  ) async {
    emit(UpcomingMoviesLoading());
    final result = await repository.getUpcomingMovies();
    result.fold(
      (l) => emit(UpcomingMoviesFailed()),
      (r) {
        _upComingMovies.addAll(r.results);
        emit(UpcomingMoviesLoaded(upComingMovies: _upComingMovies));
      },
    );
  }

  Future<FutureOr<void>> _onGetUpcomingMoviesPaginate(
    OnGetUpcomingMoviesPaginate event,
    Emitter<UpcomingMoviesState> emit,
  ) async {
    final stateLoaded = state as UpcomingMoviesLoaded;
    emit(stateLoaded.copyWith(status: PaginateStatus.loading));
    final result = await repository.getUpcomingMovies(
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(stateLoaded.copyWith(status: PaginateStatus.failed)),
      (r) {
        if (r.results.isNotEmpty) {
          _upComingMovies.addAll(r.results);
          emit(
            stateLoaded.copyWith(
              status: PaginateStatus.loaded,
              upComingMovies: _upComingMovies,
            ),
          );
        } else {
          emit(stateLoaded.copyWith(status: PaginateStatus.empty));
        }
      },
    );
  }
}
