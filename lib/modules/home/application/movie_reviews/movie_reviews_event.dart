part of 'movie_reviews_bloc.dart';

abstract class MovieReviewsEvent extends Equatable {
  const MovieReviewsEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieReviews extends MovieReviewsEvent {
  const OnGetMovieReviews({
    required this.url,
    required this.pageNumber,
  });

  final String url;
  final int pageNumber;
}
