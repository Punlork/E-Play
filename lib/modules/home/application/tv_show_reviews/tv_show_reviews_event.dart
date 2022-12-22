part of 'tv_show_reviews_bloc.dart';

abstract class TvShowReviewsEvent extends Equatable {
  const TvShowReviewsEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvShowReview extends TvShowReviewsEvent {
  const OnGetTvShowReview({
    required this.pageNumber,
    required this.tvShowId,
  });

  final int pageNumber;
  final int tvShowId;
}
