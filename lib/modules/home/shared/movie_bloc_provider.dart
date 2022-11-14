import 'package:e_book_app/modules/home/application/movie/movie_bloc.dart';
import 'package:e_book_app/modules/home/application/movie_detail/movie_detail_bloc.dart';
import 'package:e_book_app/modules/home/application/movie_suggestion/movie_suggestion_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependencies_injection.dart';

List<BlocProvider> movieBlocProvider = [
  BlocProvider<MovieBloc>(
    create: (context) => getIt<MovieBloc>(),
  ),
  BlocProvider<MovieDetailBloc>(
    create: (context) => getIt<MovieDetailBloc>(),
  ),
  BlocProvider<MovieSuggestionBloc>(
    create: (context) => getIt<MovieSuggestionBloc>(),
  ),
];
