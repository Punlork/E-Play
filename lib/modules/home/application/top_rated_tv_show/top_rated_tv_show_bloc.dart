import 'dart:async';
import 'package:e_book_app/index.dart';

part 'top_rated_tv_show_event.dart';
part 'top_rated_tv_show_state.dart';

class TopRatedTvShowBloc extends Bloc<TopRatedTvShowEvent, TopRatedTvShowState> {
  TopRatedTvShowBloc(this.repository) : super(TopRatedTvShowInitial()) {
    on<OnGetTopRatedTvShow>(_onGetTopRatedTvShow);
  }

  final TvShowsRepository repository;

  Future<FutureOr<void>> _onGetTopRatedTvShow(
    OnGetTopRatedTvShow event,
    Emitter<TopRatedTvShowState> emit,
  ) async {
    emit(TopRatedTvShowLoading());
    final result = await repository.getTopRatedTvShow(pageNumber: event.pageNumber);
    result.fold(
      (l) => emit(TopRatedTvShowFailed(l)),
      (r) => emit(TopRatedTvShowLoaded(r.results)),
    );
  }
}
