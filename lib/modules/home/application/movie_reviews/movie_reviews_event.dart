part of 'movie_reviews_bloc.dart';

abstract class MovieReviewsEvent extends Equatable {
  const MovieReviewsEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieReviews extends MovieReviewsEvent {
  const OnGetMovieReviews({
    required this.movieId,
    required this.pageNumber,
  });

  final int movieId;
  final int pageNumber;
}
