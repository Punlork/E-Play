import 'package:e_book_app/modules/app/application/theme/theme_bloc.dart';
import 'package:e_book_app/modules/dependencies_injection.dart';


void appServiceLocator() {
  getIt.registerFactory(() => ThemeBloc(getIt()));
}
