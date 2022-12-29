part of 'upcoming_movies_bloc.dart';

abstract class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object> get props => [];
}

class UpcomingMoviesInitial extends UpcomingMoviesState {}

class UpcomingMoviesLoading extends UpcomingMoviesState {}

class UpcomingMoviesLoaded extends UpcomingMoviesState {
  const UpcomingMoviesLoaded({
    this.upComingMovies = const [],
    this.hasReachLimit = false,
    this.status = PaginateStatus.initial,
  });

  final List<UpcomingMoviesModelResults> upComingMovies;
  final PaginateStatus status;
  final bool hasReachLimit;

  UpcomingMoviesLoaded copyWith({
    PaginateStatus? status,
    List<UpcomingMoviesModelResults>? upComingMovies,
    bool? hasReachLimit,
  }) {
    return UpcomingMoviesLoaded(
      status: status ?? this.status,
      upComingMovies: upComingMovies ?? this.upComingMovies,
      hasReachLimit: hasReachLimit ?? this.hasReachLimit,
    );
  }

  @override
  List<Object> get props => [status];
}

class UpcomingMoviesFailed extends UpcomingMoviesState {}
