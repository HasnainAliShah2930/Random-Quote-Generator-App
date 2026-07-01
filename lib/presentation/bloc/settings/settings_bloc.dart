import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';

// ───────────────────────── Events ─────────────────────────

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class ThemeModeToggled extends SettingsEvent {
  final ThemeMode themeMode;
  const ThemeModeToggled(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

class NotificationsToggled extends SettingsEvent {
  const NotificationsToggled();
}

class AutoCopyToggled extends SettingsEvent {
  const AutoCopyToggled();
}

class SoundToggled extends SettingsEvent {
  const SoundToggled();
}

class FontSizeChanged extends SettingsEvent {
  final AppFontSize fontSize;
  const FontSizeChanged(this.fontSize);
  @override
  List<Object?> get props => [fontSize];
}

// ───────────────────────── State ─────────────────────────

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final bool autoCopyEnabled;
  final bool soundEnabled;
  final AppFontSize fontSize;

  const SettingsState({
    this.themeMode = ThemeMode.light,
    this.notificationsEnabled = true,
    this.autoCopyEnabled = false,
    this.soundEnabled = true,
    this.fontSize = AppFontSize.medium,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? autoCopyEnabled,
    bool? soundEnabled,
    AppFontSize? fontSize,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      autoCopyEnabled: autoCopyEnabled ?? this.autoCopyEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        notificationsEnabled,
        autoCopyEnabled,
        soundEnabled,
        fontSize,
      ];
}

// ───────────────────────── Bloc ─────────────────────────

/// Provided once at the app root (not per-screen) since theme mode needs
/// to drive the top-level MaterialApp.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<ThemeModeToggled>(
      (event, emit) => emit(state.copyWith(themeMode: event.themeMode)),
    );
    on<NotificationsToggled>(
      (event, emit) => emit(
        state.copyWith(notificationsEnabled: !state.notificationsEnabled),
      ),
    );
    on<AutoCopyToggled>(
      (event, emit) =>
          emit(state.copyWith(autoCopyEnabled: !state.autoCopyEnabled)),
    );
    on<SoundToggled>(
      (event, emit) => emit(state.copyWith(soundEnabled: !state.soundEnabled)),
    );
    on<FontSizeChanged>(
      (event, emit) => emit(state.copyWith(fontSize: event.fontSize)),
    );
  }
}
