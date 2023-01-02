import 'dart:async';
import 'package:e_book_app/index.dart';

part 'show_all_event.dart';
part 'show_all_state.dart';

class ShowAllBloc extends Bloc<ShowAllEvent, ShowAllState> {
  ShowAllBloc(this.repository) : super(ShowAllInitial()) {
    on<ShowAllFetched>(_onShowAllFetched);
    // on<ShowAllClear>(_onShowAllClear);
    on<ShowAllFetchedPaginate>(_onShowAllFetchedPaginate);
  }

  final ShowAllRepository repository;
  final listOfShowAll = <ShowAllModelResult>[];

  Future<FutureOr<void>> _onShowAllFetched(
    ShowAllFetched event,
    Emitter<ShowAllState> emit,
  ) async {
    listOfShowAll.clear();
    emit(ShowAllLoading());
    final result = await repository.showAllFetched(
      url: event.url,
    );
    result.fold(
      (l) => emit(ShowAllFailed(l)),
      (r) => {
        listOfShowAll.addAll(r.results),
        emit(ShowAllLoaded(showAll: listOfShowAll)),
      },
    );
  }

  Future<FutureOr<void>> _onShowAllFetchedPaginate(
    ShowAllFetchedPaginate event,
    Emitter<ShowAllState> emit,
  ) async {
    final stateLoaded = state as ShowAllLoaded;
    emit(stateLoaded.copyWith(status: PaginateStatus.loading));
    final result = await repository.showAllFetched(
      url: event.url,
      pageNumber: event.pageNumber,
    );
    result.fold(
      (l) => emit(stateLoaded.copyWith(status: PaginateStatus.failed)),
      (r) => {
        if (r.results.isNotEmpty)
          {
            listOfShowAll.addAll(r.results),
            emit(
              stateLoaded.copyWith(
                status: PaginateStatus.loaded,
                showAll: listOfShowAll,
                hasReachLimit: false,
              ),
            ),
          }
        else
          {
            emit(
              stateLoaded.copyWith(
                status: PaginateStatus.empty,
                hasReachLimit: true,
              ),
            ),
          }
      },
    );
  }
}
