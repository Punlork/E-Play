part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  const MovieDetailLoaded(this.movieDetail);

  final MovieAndSeriesDetailResModel movieDetail;
}

class MovieDetailFailed extends MovieDetailState {
  const MovieDetailFailed(this.message);

  final String message;
}
