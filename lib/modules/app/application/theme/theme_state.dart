part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  const ThemeState({this.theme = ThemeMode.system});

  factory ThemeState.initial() => const ThemeState();

  final ThemeMode theme;

  ThemeState copyWith({ThemeMode? theme}) => ThemeState(
        theme: theme ?? this.theme,
      );

  @override
  List<Object?> get props => [theme];
}
