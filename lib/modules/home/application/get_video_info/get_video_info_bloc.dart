import 'dart:async';
import 'package:e_book_app/index.dart';

part 'get_video_info_event.dart';
part 'get_video_info_state.dart';

class GetVideoInfoBloc extends Bloc<GetVideoInfoEvent, GetVideoInfoState> {
  GetVideoInfoBloc(this.repository) : super(GetVideoInfoInitial()) {
    on<OnGetVideoInfo>(_onGetVideoInfo);
  }

  final MovieRepository repository;

  Future<FutureOr<void>> _onGetVideoInfo(
    OnGetVideoInfo event,
    Emitter<GetVideoInfoState> emit,
  ) async {
    emit(GetVideoInfoLoading());
    final result = await repository.getVideoInfo(movieId: event.movieId);
    result.fold(
      (l) => emit(GetVideoInfoFailed(l)),
      (r) => emit(GetVideoInfoLoaded(r.results)),
    );
  }
}
