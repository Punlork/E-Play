import 'dart:async';
import 'package:e_book_app/index.dart';

part 'tv_show_detail_event.dart';
part 'tv_show_detail_state.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  TvShowDetailBloc(this.repository) : super(TvShowDetailInitial()) {
    on<OnGetTvShowDetail>(_onGetTvShowDetail);
    on<OnRemoveTvShow>(_onRemoveTvShow);
  }

  final TvShowsRepository repository;
  final List<TvShowDetailModel> _listTvShows = [];
  final List<int> _tvShowsIndexes = [];

  Future<FutureOr<void>> _onGetTvShowDetail(
    OnGetTvShowDetail event,
    Emitter<TvShowDetailState> emit,
  ) async {
    emit(TvShowDetailLoading());
    _tvShowsIndexes.add(event.tvShowId);

    final result = await repository.getTvShowDetail(
      tvShowId: _tvShowsIndexes.last,
    );
    result.fold(
      (l) => emit(TvShowDetailFailed(l)),
      (r) => {
        _listTvShows.add(r),
        emit(TvShowDetailLoaded(_listTvShows)),
      },
    );
  }

  Future<FutureOr<void>> _onRemoveTvShow(
    OnRemoveTvShow event,
    Emitter<TvShowDetailState> emit,
  ) async {
    emit(TvShowDetailLoading());
    try {
      _listTvShows.removeLast();
      _tvShowsIndexes.removeLast();
      emit(TvShowDetailLoaded(_listTvShows));
    } catch (e) {
      emit(TvShowDetailFailed(e.toString()));
    }
  }
}
