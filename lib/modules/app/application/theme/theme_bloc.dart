import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this.prefs) : super(ThemeState.initial()) {
    on<OnThemeChecked>(_onThemeChecked);
    on<OnThemeChanged>(_onThemeChanged);
  }
  final SharedPreferences prefs;

  FutureOr<void> _onThemeChecked(OnThemeChecked event, Emitter<ThemeState> emit) {
    final theme = prefs.getString('theme');
    if (theme != null) {
      emit(state.copyWith(theme: _stringToThemeMode(theme)));
    }
  }

  Future<FutureOr<void>> _onThemeChanged(OnThemeChanged event, Emitter<ThemeState> emit) async {
    await prefs.setString('theme', _themeModeToString(event.mode));
    emit(state.copyWith(theme: event.mode));
  }

  ThemeMode _stringToThemeMode(String mode) {
    switch (mode) {
      case 'ThemeMode.system':
        return ThemeMode.system;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'ThemeMode.system';
      case ThemeMode.dark:
        return 'ThemeMode.dark';
      case ThemeMode.light:
        return 'ThemeMode.light';
    }
  }
}
