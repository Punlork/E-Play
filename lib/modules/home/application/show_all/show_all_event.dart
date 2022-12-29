part of 'show_all_bloc.dart';

abstract class ShowAllEvent extends Equatable {
  const ShowAllEvent();

  @override
  List<Object> get props => [];
}

class ShowAllFetched extends ShowAllEvent {
  const ShowAllFetched(this.url);

  final String url;
}

class ShowAllFetchedPaginate extends ShowAllEvent {
  const ShowAllFetchedPaginate({
    required this.pageNumber,
    required this.url,
  });

  final int pageNumber;
  final String url;
}
