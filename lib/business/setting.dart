import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ChangeLocaleEvent extends ThemeEvent {
  Locale lo;
  ChangeLocaleEvent({required this.lo});
}

class ChangeScreenEvent extends ThemeEvent {
  int index;
  ChangeScreenEvent({required this.index});
}

class ThemeState {
  bool isDarkModeEnabled;
  Locale local;
  int index;

  ThemeState({required this.isDarkModeEnabled, required this.local, required this.index});

  ThemeState.initialState()
      : this(isDarkModeEnabled: false, local: const Locale("en"), index: 0);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initialState()) {
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeState(
          isDarkModeEnabled: !state.isDarkModeEnabled, local: state.local, index: state.index));
    });
    on<ChangeLocaleEvent>((event, emit) {
      emit(ThemeState(
          isDarkModeEnabled: state.isDarkModeEnabled, local: event.lo, index: state.index));
    });
    on<ChangeScreenEvent>((event, emit) {
      emit(ThemeState(
          isDarkModeEnabled: state.isDarkModeEnabled, local: state.local, index: event.index));
    });
  }
}
