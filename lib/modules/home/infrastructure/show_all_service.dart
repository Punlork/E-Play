import 'package:e_book_app/index.dart';

class ShowAllService {
  ShowAllService(this._service);

  final Dio _service;

  Future<ShowAllModel> showAllFetched({
    required int pageNumber,
    required String url,
  }) async {
    final response = await _service.get<dynamic>(
      url,
    );
    return ShowAllModel.fromJson(response.data);
  }
}
