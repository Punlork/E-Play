part of 'tv_show_video_bloc.dart';

abstract class TvShowVideoEvent extends Equatable {
  const TvShowVideoEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvShowVideo extends TvShowVideoEvent {
  const OnGetTvShowVideo(this.showId);

  final int showId;
}
