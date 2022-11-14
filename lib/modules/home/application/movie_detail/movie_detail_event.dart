part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieDetail extends MovieDetailEvent {
  const OnGetMovieDetail({
    this.movieId,
  });

  final int? movieId;

}
