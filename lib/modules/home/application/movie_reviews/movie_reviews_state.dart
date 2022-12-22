part of 'movie_reviews_bloc.dart';

abstract class MovieReviewsState extends Equatable {
  const MovieReviewsState();

  @override
  List<Object> get props => [];
}

class MovieReviewsInitial extends MovieReviewsState {}

class MovieReviewsLoading extends MovieReviewsState {}

class MovieReviewsLoaded extends MovieReviewsState {
  const MovieReviewsLoaded(this.movieReviews);

  final List<MovieReviewsResults> movieReviews;
}

class MovieReviewsFailed extends MovieReviewsState {
  const MovieReviewsFailed(this.message);

  final String message;
}
