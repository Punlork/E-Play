part of 'movie_reviews_bloc.dart';

abstract class MovieReviewsState extends Equatable {
  const MovieReviewsState();

  @override
  List<Object> get props => [];
}

class MovieReviewsInitial extends MovieReviewsState {}

class MovieReviewsLoading extends MovieReviewsState {}

class MovieReviewsLoaded extends MovieReviewsState {
  const MovieReviewsLoaded({
    this.movieReviews = const [],
    this.status = PaginateStatus.initial,
    this.hasReachLimit = false,
  });

  final List<MovieReviewsResults> movieReviews;
  final PaginateStatus status;
  final bool hasReachLimit;

  MovieReviewsLoaded copyWith({
    List<MovieReviewsResults>? movieReviews,
    PaginateStatus? status,
    bool? hasReachLimit,
  }) {
    return MovieReviewsLoaded(
      movieReviews: movieReviews ?? this.movieReviews,
      status: status ?? this.status,
      hasReachLimit: hasReachLimit ?? this.hasReachLimit,
    );
  }

  @override
  List<Object> get props => [status];
}

class MovieReviewsFailed extends MovieReviewsState {
  const MovieReviewsFailed(this.message);

  final String message;
}
