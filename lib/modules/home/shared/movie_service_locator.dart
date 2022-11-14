import 'package:e_book_app/modules/home/application/movie/movie_bloc.dart';
import 'package:e_book_app/modules/home/application/movie_detail/movie_detail_bloc.dart';
import 'package:e_book_app/modules/home/application/movie_suggestion/movie_suggestion_bloc.dart';
import 'package:e_book_app/modules/home/infrastructure/movie_repository.dart';
import 'package:e_book_app/modules/home/infrastructure/movie_service.dart';

import '../../dependencies_injection.dart';

void movieServiceLocator() {
  getIt
    ..registerLazySingleton<MovieService>(() => MovieService(getIt()))
    ..registerLazySingleton<MovieRepository>(
      () => MoviewRepositoryImpl(getIt()),
    )
    ..registerFactory<MovieBloc>(() => MovieBloc(getIt()))
    ..registerFactory<MovieDetailBloc>(() => MovieDetailBloc(getIt()))
    ..registerFactory<MovieSuggestionBloc>(() => MovieSuggestionBloc(getIt()));
}
