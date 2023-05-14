import 'dart:ui';

import 'package:divice/domain/services/share_reference.dart';
import 'package:divice/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ChangeLocaleEvent extends ThemeEvent {
  Locale lo;
  ChangeLocaleEvent({required this.lo});
}

class ThemeEventSetup extends ThemeEvent {}

class ThemeState {
  bool isDarkModeEnabled;
  Locale local;

  ThemeState({
    required this.isDarkModeEnabled,
    required this.local,
  });

  bool get defaultIsDarkMode => false;
  Locale get defaultLanguage => const Locale("en");

  ThemeState.initialState()
      : this(
          isDarkModeEnabled: false,
          local: const Locale("en"),
        );

  ThemeState copyWith({
    bool? isDarkModeEnabled,
    Locale? local,
  }) {
    return ThemeState(
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      local: local ?? this.local,
    );
  }
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initialState()) {
    on<ToggleThemeEvent>((event, emit) {
      bool newIsDarkMode = !state.isDarkModeEnabled;
      emit(ThemeState(
        isDarkModeEnabled: newIsDarkMode,
        local: state.local,
      ));
      ShareReferenceService.saveDarkMode(newIsDarkMode);
    });
    on<ChangeLocaleEvent>((event, emit) {
      emit(state.copyWith(local: event.lo));
      ShareReferenceService.saveLanguageMode(event.lo);
    });
    on<ThemeEventSetup>(_setupTheme);
  }

  void _setupTheme(ThemeEventSetup event, Emitter<ThemeState> emit) async {
    bool isDarkMode = await ShareReferenceService.getDarkMode() ??
        ThemeState.initialState().defaultIsDarkMode;

    String? localeString = await ShareReferenceService.getLanguageMode();
    Locale local = ThemeState.initialState().defaultLanguage;

    if (localeString != null) {
      for (var element in S.delegate.supportedLocales) {
        if (element.toString() == localeString) {
          local = element;
          break;
        }
      }
    }

    emit(state.copyWith(isDarkModeEnabled: isDarkMode, local: local));
  }
}
