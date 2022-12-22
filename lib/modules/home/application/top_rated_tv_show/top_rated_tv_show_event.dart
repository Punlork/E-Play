part of 'top_rated_tv_show_bloc.dart';

abstract class TopRatedTvShowEvent extends Equatable {
  const TopRatedTvShowEvent();

  @override
  List<Object> get props => [];
}

class OnGetTopRatedTvShow extends TopRatedTvShowEvent {
  const OnGetTopRatedTvShow(this.pageNumber);

  final int pageNumber;
}
