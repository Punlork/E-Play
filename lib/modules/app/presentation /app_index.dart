import 'package:e_book_app/common/l10n/l10n.dart';
import 'package:e_book_app/index.dart';
import 'package:e_book_app/modules/app_provider.dart';
import 'package:e_book_app/modules/app_router.dart';
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
            textTheme: _textTheme(),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: AppColors.black,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.red,
              secondary: Color(0xffffffff),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.grey,
            ),
            textTheme: _textTheme(),
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

  TextTheme _textTheme() {
    return TextTheme(
      headlineLarge: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleLarge: GoogleFonts.quicksand(
        color: AppColors.red,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.quicksand(
        color: AppColors.white,
        fontSize: 10,
        // fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.quicksand(
        color: AppColors.white,
        fontSize: 10,
        letterSpacing: 2,
        height: 2,
      ),
      labelMedium: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: AppColors.white,
      ),
      labelLarge: GoogleFonts.quicksand(
        fontSize: 11,
        color: AppColors.gray,
        // fontWeight: FontWeight.bold,
      ),
    );
  }
}
