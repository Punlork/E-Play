part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  const PopularMoviesLoaded({
    this.popularMovies = const [],
    this.status = PaginateStatus.initial,
    this.hasReachLimit = false,
  });

  final PaginateStatus status;
  final bool hasReachLimit;

  final List<PopularMoviesData> popularMovies;

  PopularMoviesLoaded copyWith({
    PaginateStatus? status,
    bool? hasReachLimit,
    List<PopularMoviesData>? popularMovies,
  }) {
    return PopularMoviesLoaded(
      hasReachLimit: hasReachLimit ?? this.hasReachLimit,
      popularMovies: popularMovies ?? this.popularMovies,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

class PopularMoviesFailure extends PopularMoviesState {
  const PopularMoviesFailure(this.message);

  final String message;
}
