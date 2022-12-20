part of 'get_video_info_bloc.dart';

abstract class GetVideoInfoEvent extends Equatable {
  const GetVideoInfoEvent();

  @override
  List<Object> get props => [];
}

class OnGetVideoInfo extends GetVideoInfoEvent {
  const OnGetVideoInfo(this.movieId);

  final int movieId;
}
