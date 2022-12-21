part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvShowDetail extends TvShowDetailEvent {
  const OnGetTvShowDetail(this.tvShowId);

  final int tvShowId;
}

class OnRemoveTvShow extends TvShowDetailEvent {}
