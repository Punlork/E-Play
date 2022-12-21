part of 'tv_show_video_bloc.dart';

abstract class TvShowVideoState extends Equatable {
  const TvShowVideoState();

  @override
  List<Object> get props => [];
}

class TvShowVideoInitial extends TvShowVideoState {}

class TvShowVideoLoading extends TvShowVideoState {}

class TvShowVideoLoaded extends TvShowVideoState {
  const TvShowVideoLoaded(this.tvShowVideos);

  final List<GetTvShowVideoResults> tvShowVideos;
}

class TvShowVideoFailed extends TvShowVideoState {
  const TvShowVideoFailed(this.message);

  final String message;
}
