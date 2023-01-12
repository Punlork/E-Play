import 'dart:convert';
import 'dart:developer';

import 'package:e_book_app/index.dart';
import 'package:loading_more_list/loading_more_list.dart';

class TuChangRepository extends LoadingMoreBase<ShowAllModel> {
  TuChangRepository(this.url);

  final Dio _dio = Dio();

  final String url;

  int pageIndex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;

  @override
  bool get hasMore => (_hasMore && length < 30) || forceRefresh;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    pageIndex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !clearBeforeRequest;
    final result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    final url = this.url;

    var isSuccess = false;

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final result = await _dio.get<dynamic>('$url$pageIndex');

      final source = ShowAllModel.fromJson(result.data);
      // if (pageIndex == 1) {
      //   this.clear();
      // }
      // for (var item in source.feedList) {
      //   if (item.hasImage && !this.contains(item) && hasMore) this.add(item);
      // }
      source.results.forEach((element) {
        log(element.title);
      });

      add(source);

      // if (pageIndex == 1) {
      //   clear();
      // }

      _hasMore = source.results.isNotEmpty;
      pageIndex += 1;
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }
}
