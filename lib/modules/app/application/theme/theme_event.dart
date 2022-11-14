part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {}

class OnThemeChecked extends ThemeEvent {
  @override
  List<Object?> get props => [];
}

class OnThemeChanged extends ThemeEvent {
  OnThemeChanged(this.mode);

  final ThemeMode mode;

  @override
  List<Object?> get props => [mode];
}
