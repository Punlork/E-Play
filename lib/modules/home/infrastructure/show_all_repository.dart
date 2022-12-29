import 'package:dartz/dartz.dart';
import 'package:e_book_app/index.dart';

abstract class ShowAllRepository {
  Future<Either<String, ShowAllModel>> showAllFetched({
    int pageNumber,
    String url,
  });
}

class ShowAllRepositoryImpl implements ShowAllRepository {
  ShowAllRepositoryImpl(this._service);

  final ShowAllService _service;
  @override
  Future<Either<String, ShowAllModel>> showAllFetched({
    int pageNumber = 1,
    String url = '',
  }) async {
    try {
      final response = await _service.showAllFetched(
        pageNumber: pageNumber,
        url: url,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
