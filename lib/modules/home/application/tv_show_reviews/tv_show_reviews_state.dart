part of 'tv_show_reviews_bloc.dart';

abstract class TvShowReviewsState extends Equatable {
  const TvShowReviewsState();

  @override
  List<Object> get props => [];
}

class TvShowReviewsInitial extends TvShowReviewsState {}

class TvShowReviewsLoading extends TvShowReviewsState {}

class TvShowReviewsLoaded extends TvShowReviewsState {
  const TvShowReviewsLoaded(this.tvShowReviews);

  final List<TvShowReviewsResults> tvShowReviews;
}

class TvShowReviewsFailed extends TvShowReviewsState {
  const TvShowReviewsFailed(this.message);

  final String message;
}
