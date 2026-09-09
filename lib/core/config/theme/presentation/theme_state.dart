import 'package:flutter/material.dart';

enum ThemeStatus {
  initial,
  loading,
  success,
  failure,
}

class ThemeState {
  final ThemeMode themeMode;
  final ThemeStatus status;
  final String? errorMessage;

  const ThemeState({
    this.themeMode = ThemeMode.light,
    this.status = ThemeStatus.initial,
    this.errorMessage,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    ThemeStatus? status,
    String? errorMessage,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isDark => themeMode == ThemeMode.dark;

  bool get isLight => themeMode == ThemeMode.light;
}