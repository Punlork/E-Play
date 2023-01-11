import 'dart:async';
import 'package:e_book_app/index.dart';

part 'movie_reviews_event.dart';
part 'movie_reviews_state.dart';

class MovieReviewsBloc extends Bloc<MovieReviewsEvent, MovieReviewsState> {
  MovieReviewsBloc(this.repository) : super(MovieReviewsInitial()) {
    on<OnGetMovieReviews>(_onGetMovieReviews);
    on<OnGetMovieReviewsNext>(_onGetMovieReviewsNext);
  }

  final MovieRepository repository;

  bool get isReachedLimit => (state as MovieReviewsLoaded).hasReachLimit;

  Future<FutureOr<void>> _onGetMovieReviews(
    OnGetMovieReviews event,
    Emitter<MovieReviewsState> emit,
  ) async {
    emit(MovieReviewsLoading());
    final result = await repository.getMovieReviews(
      url: event.url,
    );
    result.fold(
      (l) => emit(MovieReviewsFailed(l)),
      (r) => emit(MovieReviewsLoaded(movieReviews: r.results)),
    );
  }

  Future<FutureOr<void>> _onGetMovieReviewsNext(
    OnGetMovieReviewsNext event,
    Emitter<MovieReviewsState> emit,
  ) async {
    final stateLoaded = state as MovieReviewsLoaded;
    emit(stateLoaded.copyWith(status: PaginateStatus.loading));
    final result = await repository.getMovieReviews(
      pageNumber: event.pageNumber,
      url: event.url,
    );
    result.fold(
      (l) => emit(stateLoaded.copyWith(status: PaginateStatus.failed)),
      (r) => {
        if (r.results.isNotEmpty)
          emit(
            stateLoaded.copyWith(
              hasReachLimit: false,
              movieReviews: r.results,
              status: PaginateStatus.loaded,
            ),
          )
        else
          {
            emit(
              stateLoaded.copyWith(
                status: PaginateStatus.empty,
                hasReachLimit: true,
              ),
            ),
          }
      },
    );
  }
}
