import 'dart:async';
import 'package:e_book_app/index.dart';

part 'get_trending_event.dart';
part 'get_trending_state.dart';

class GetTrendingBloc extends Bloc<GetTrendingEvent, GetTrendingState> {
  GetTrendingBloc(this.repository) : super(GetTrendingInitial()) {
    on<OnGetTrending>(_onGetTrending);
  }

  final MovieRepository repository;

  Future<FutureOr<void>> _onGetTrending(
    OnGetTrending event,
    Emitter<GetTrendingState> emit,
  ) async {
    emit(GetTrendingLoading());
    final result = await repository.getTrending(mediaType: event.mediaType);
    result.fold(
      (l) => emit(GetTrendingFailed(l)),
      (r) => emit(GetTrendingLoaded(r.results!)),
    );
  }
}
