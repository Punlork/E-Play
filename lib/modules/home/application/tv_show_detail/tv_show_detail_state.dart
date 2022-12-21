part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object> get props => [];
}

class TvShowDetailInitial extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailLoaded extends TvShowDetailState {
  const TvShowDetailLoaded(this.tvShowDetail);

  final List<TvShowDetailModel> tvShowDetail;
}

class TvShowDetailFailed extends TvShowDetailState {
  const TvShowDetailFailed(this.message);

  final String message;
}
