import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}
class ChangeLocaleEvent extends ThemeEvent {
  Locale lo;
  ChangeLocaleEvent({ required this.lo});
}

class ThemeState {
  bool isDarkModeEnabled;
  Locale local;

  ThemeState({required this.isDarkModeEnabled, required this.local});

  ThemeState.initialState() : this(isDarkModeEnabled: false, local: const Locale("en"));
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initialState()){
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeState(isDarkModeEnabled: !state.isDarkModeEnabled, local: state.local));
    });
    on<ChangeLocaleEvent>((event, emit) {
      emit(ThemeState(isDarkModeEnabled: state.isDarkModeEnabled, local: event.lo));
    });
    ;
  }
}