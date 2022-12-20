import 'dart:async';
import 'package:e_book_app/index.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTvShowsBloc extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  PopularTvShowsBloc(this.repository) : super(PopularTvShowsInitial()) {
    on<OnGetPopularTvShow>(_onGetPopularTvShows);
  }

  final TvShowsRepository repository;

  Future<FutureOr<void>> _onGetPopularTvShows(
    OnGetPopularTvShow event,
    Emitter<PopularTvShowsState> emit,
  ) async {
    final result = await repository.getPopularTvShows(
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(PopularTvShowsFailed(l)),
      (r) => emit(PopularTvShowsLoaded(r.results)),
    );
  }
}
