part of 'show_all_bloc.dart';

abstract class ShowAllState extends Equatable {
  const ShowAllState();

  @override
  List<Object> get props => [];
}

class ShowAllInitial extends ShowAllState {}

class ShowAllLoading extends ShowAllState {}

class ShowAllLoaded extends ShowAllState {
  const ShowAllLoaded({
    this.status = PaginateStatus.initial,
    this.showAll = const [],
    this.hasReachLimit = false,
  });

  final PaginateStatus status;
  final List<ShowAllModelResult> showAll;
  final bool hasReachLimit;

  ShowAllLoaded copyWith({
    PaginateStatus? status,
    List<ShowAllModelResult>? showAll,
    bool? hasReachLimit,
  }) {
    return ShowAllLoaded(
      showAll: showAll ?? this.showAll,
      status: status ?? this.status,
      hasReachLimit: hasReachLimit ?? this.hasReachLimit,
    );
  }

  @override
  List<Object> get props => [status];
}

class ShowAllFailed extends ShowAllState {
  const ShowAllFailed(this.message);

  final String message;
}
