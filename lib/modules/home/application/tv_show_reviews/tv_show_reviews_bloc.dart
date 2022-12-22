import 'dart:async';
import 'package:e_book_app/index.dart';

part 'tv_show_reviews_event.dart';
part 'tv_show_reviews_state.dart';

class TvShowReviewsBloc extends Bloc<TvShowReviewsEvent, TvShowReviewsState> {
  TvShowReviewsBloc(this.repository) : super(TvShowReviewsInitial()) {
    on<OnGetTvShowReview>(_onGetTvShowReview);
  }

  final TvShowsRepository repository;

  Future<FutureOr<void>> _onGetTvShowReview(
    OnGetTvShowReview event,
    Emitter<TvShowReviewsState> emit,
  ) async {
    emit(TvShowReviewsLoading());
    final result = await repository.getTvShowReviews(
      pageNumber: event.pageNumber,
      tvShowId: event.tvShowId,
    );
    result.fold(
      (l) => emit(TvShowReviewsFailed(l)),
      (r) => emit(TvShowReviewsLoaded(r.results)),
    );
  }
}
