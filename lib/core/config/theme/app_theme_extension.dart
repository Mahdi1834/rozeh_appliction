import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color primary;
  final Color secondary;

  final Color background;
  final Color surface;
  final Color card;

  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;

  final Color border;
  final Color divider;

  final Color inputBackground;

  final Color navigationBackground;

  final Color success;
  final Color warning;
  final Color warning2;
  final Color warningBKProfile;
  final Color error;

  final Color shadow;

  const AppThemeColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.border,
    required this.divider,
    required this.inputBackground,
    required this.navigationBackground,
    required this.success,
    required this.warning,
    required this.warning2,
    required this.warningBKProfile,
    required this.error,
    required this.shadow,
  });

  @override
  AppThemeColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? border,
    Color? divider,
    Color? inputBackground,
    Color? navigationBackground,
    Color? success,
    Color? warning,
    Color? warning2,
    Color? warningBKProfile,
    Color? error,
    Color? shadow,
  }) {
    return AppThemeColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      inputBackground: inputBackground ?? this.inputBackground,
      navigationBackground: navigationBackground ?? this.navigationBackground,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      warning2: warning2 ?? this.warning2,
      warningBKProfile: warningBKProfile ?? this.warningBKProfile,
      error: error ?? this.error,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppThemeColors lerp(covariant AppThemeColors? other, double t) {
    if (other == null) {
      return this;
    }

    return AppThemeColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      navigationBackground:
          Color.lerp(navigationBackground, other.navigationBackground, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warning2: Color.lerp(warning2, other.warning2, t)!,
      warningBKProfile:
          Color.lerp(warningBKProfile, other.warningBKProfile, t)!,
      error: Color.lerp(error, other.error, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}
