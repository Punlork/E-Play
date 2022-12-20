part of 'popular_tv_shows_bloc.dart';

abstract class PopularTvShowsState extends Equatable {
  const PopularTvShowsState();

  @override
  List<Object> get props => [];
}

class PopularTvShowsInitial extends PopularTvShowsState {}

class PopularTvShowsLoading extends PopularTvShowsState {}

class PopularTvShowsLoaded extends PopularTvShowsState {
  const PopularTvShowsLoaded(this.popularTvShows);

  final List<PopularTVShowModelResults> popularTvShows;
}

class PopularTvShowsFailed extends PopularTvShowsState {
  const PopularTvShowsFailed(this.message);

  final String message;
}
