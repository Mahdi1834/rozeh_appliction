import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'app_theme_extension.dart';

class AppThemePalettes {
  AppThemePalettes._();

  static const light = AppThemeColors(
    // Primary
    primary: ConsColors.greenBg,
    secondary: ConsColors.blueBg2,

    // Background
    background: ConsColors.lightBackground,
    surface: ConsColors.lightSurface,
    card: ConsColors.lightCard,

    // Text
    textPrimary: ConsColors.blue,
    textSecondary: ConsColors.gray,
    textDisabled: ConsColors.grayDisabled,

    // Border / Divider
    border: ConsColors.borderInactive,
    divider: ConsColors.dividerGreen,

    // Input
    inputBackground: ConsColors.lightInput,

    // Navigation
    navigationBackground: Colors.white,

    // Status
    success: ConsColors.green,
    warning: ConsColors.orange,
    warning2: ConsColors.orange2,
    warningBKProfile: ConsColors.yellowBKProfile,
    error: ConsColors.error,

    // Shadow
    shadow: ConsColors.shadow,
  );

  static const dark = AppThemeColors(
    // Primary
    primary: ConsColors.greenBg,
    secondary: ConsColors.blueBg2,

    // Background
    background: ConsColors.darkBackground,
    surface: ConsColors.darkSurface,
    card: ConsColors.darkCard,

    // Text
    textPrimary: ConsColors.darkTextPrimary,
    textSecondary: ConsColors.darkTextSecondary,
    textDisabled: ConsColors.darkTextDisabled,

    // Border / Divider
    border: ConsColors.darkBorderInactive,
    divider: ConsColors.darkDivider,

    // Input
    inputBackground: ConsColors.darkInput,

    // Navigation
    navigationBackground: ConsColors.darkNavigation,

    // Status
    success: ConsColors.greenBg,
    warning: ConsColors.orange,
    warning2: ConsColors.orange2,
    warningBKProfile: Color(0xFF442E2A),
    error: ConsColors.error,

    // Shadow
    shadow: ConsColors.darkShadow,
  );
}
