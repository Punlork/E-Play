import 'dart:async';
import 'package:e_book_app/index.dart';

part 'movie_reviews_event.dart';
part 'movie_reviews_state.dart';

class MovieReviewsBloc extends Bloc<MovieReviewsEvent, MovieReviewsState> {
  MovieReviewsBloc(this.repository) : super(MovieReviewsInitial()) {
    on<OnGetMovieReviews>(_onGetMovieReviews);
  }

  final MovieRepository repository;

  Future<FutureOr<void>> _onGetMovieReviews(
    OnGetMovieReviews event,
    Emitter<MovieReviewsState> emit,
  ) async {
    emit(MovieReviewsLoading());
    final result = await repository.getMovieReviews(
      movieId: event.movieId,
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(MovieReviewsFailed(l)),
      (r) => emit(MovieReviewsLoaded(r.results)),
    );
  }
}
