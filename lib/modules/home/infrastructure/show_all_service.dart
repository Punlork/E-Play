import 'dart:developer';

import 'package:e_book_app/index.dart';

class ShowAllService {
  ShowAllService(this._service);

  final Dio _service;

  Future<ShowAllModel> showAllFetched({
    required String url,
    required int pageNumber,
  }) async {
    log(url + pageNumber.toString());
    final response = await _service.get<dynamic>(
      url + pageNumber.toString(),
    );
    return ShowAllModel.fromJson(response.data);
  }
}
