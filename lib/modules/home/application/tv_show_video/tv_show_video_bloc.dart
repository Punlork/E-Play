import 'dart:async';
import 'package:e_book_app/index.dart';

part 'tv_show_video_event.dart';
part 'tv_show_video_state.dart';

class TvShowVideoBloc extends Bloc<TvShowVideoEvent, TvShowVideoState> {
  TvShowVideoBloc(this.repository) : super(TvShowVideoInitial()) {
    on<OnGetTvShowVideo>(_onGetTvShowVideo);
  }

  final TvShowsRepository repository;

  Future<FutureOr<void>> _onGetTvShowVideo(
    OnGetTvShowVideo event,
    Emitter<TvShowVideoState> emit,
  ) async {
    emit(TvShowVideoLoading());
    final result = await repository.getTvShowVideo(tvShowId: event.showId);
    result.fold(
      (l) => emit(TvShowVideoFailed(l)),
      (r) => emit(TvShowVideoLoaded(r.results)),
    );
  }
}
