part of 'top_rated_tv_show_bloc.dart';

abstract class TopRatedTvShowState extends Equatable {
  const TopRatedTvShowState();

  @override
  List<Object> get props => [];
}

class TopRatedTvShowInitial extends TopRatedTvShowState {}

class TopRatedTvShowLoading extends TopRatedTvShowState {}

class TopRatedTvShowLoaded extends TopRatedTvShowState {
  const TopRatedTvShowLoaded(this.topRatedTvShow);

  final List<TopRatedTvShowResults> topRatedTvShow;
}

class TopRatedTvShowFailed extends TopRatedTvShowState {
  const TopRatedTvShowFailed(this.message);

  final String message;
}
