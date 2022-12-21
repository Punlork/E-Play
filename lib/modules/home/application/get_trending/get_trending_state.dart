part of 'get_trending_bloc.dart';

abstract class GetTrendingState extends Equatable {
  const GetTrendingState();

  @override
  List<Object> get props => [];
}

class GetTrendingInitial extends GetTrendingState {}

class GetTrendingLoading extends GetTrendingState {}

class GetTrendingLoaded extends GetTrendingState {
  const GetTrendingLoaded(this.trendingResult);

  final List<TrendingModelResults> trendingResult;
}

class GetTrendingFailed extends GetTrendingState {
  const GetTrendingFailed(this.message);

  final String message;
}
