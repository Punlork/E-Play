part of 'get_video_info_bloc.dart';

abstract class GetVideoInfoState extends Equatable {
  const GetVideoInfoState();

  @override
  List<Object> get props => [];
}

class GetVideoInfoInitial extends GetVideoInfoState {}

class GetVideoInfoLoading extends GetVideoInfoState {}

class GetVideoInfoLoaded extends GetVideoInfoState {
  const GetVideoInfoLoaded(this.videoInfo);

  final List<VideoModelResults> videoInfo;
}

class GetVideoInfoFailed extends GetVideoInfoState {
  const GetVideoInfoFailed(this.message);

  final String message;
}
