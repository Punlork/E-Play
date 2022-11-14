import 'package:e_book_app/modules/app/shared/theme_bloc_provider.dart';
import 'package:e_book_app/modules/home/shared/movie_bloc_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider {
  static List<BlocProvider> getProvider() {
    return [
      ...appBlocProvider,
      ...movieBlocProvider,
    ];
  }
}
