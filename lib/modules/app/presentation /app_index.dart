import 'package:e_book_app/common/l10n/l10n.dart';
import 'package:e_book_app/modules/app/application/theme/theme_bloc.dart';
import 'package:e_book_app/modules/app_provider.dart';
import 'package:e_book_app/modules/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppIndex extends StatelessWidget {
  const AppIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProvider.getProvider(),
      child: const _AppIndex(),
    );
  }
}

class _AppIndex extends StatelessWidget {
  const _AppIndex();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeBloc, ThemeState, ThemeMode>(
      selector: (state) {
        return state.theme;
      },
      builder: (context, state) {
        return MaterialApp.router(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xff51A8DE),
              secondary: Color(0xff1C1C1C),
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff51A8DE),
              secondary: Color(0xffffffff),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.grey,
            ),
          ),
          themeMode: state,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          routerConfig: appRouter,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
