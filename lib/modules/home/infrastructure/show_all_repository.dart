import 'package:dartz/dartz.dart';
import 'package:e_book_app/index.dart';

abstract class ShowAllRepository {
  Future<Either<String, ShowAllModel>> showAllFetched({
    String url,
    int pageNumber,
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
        url: url,
        pageNumber: pageNumber,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
