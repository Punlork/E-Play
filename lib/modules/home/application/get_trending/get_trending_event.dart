part of 'get_trending_bloc.dart';

abstract class GetTrendingEvent extends Equatable {
  const GetTrendingEvent();

  @override
  List<Object> get props => [];
}

class OnGetTrending extends GetTrendingEvent {
  const OnGetTrending(this.mediaType);

  final String mediaType;
}
