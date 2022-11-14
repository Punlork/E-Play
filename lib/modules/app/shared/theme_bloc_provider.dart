import 'package:e_book_app/modules/app/application/theme/theme_bloc.dart';
import 'package:e_book_app/modules/dependencies_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> appBlocProvider = [
  BlocProvider<ThemeBloc>(
    create: (context) => getIt<ThemeBloc>()..add(OnThemeChecked()),
  ),
];
