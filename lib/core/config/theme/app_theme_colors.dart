import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'app_theme_extension.dart';

class AppThemePalettes {
  AppThemePalettes._();

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static final light = AppThemeColors(
    // ----------------------------------------------------------
    // Primary
    // ----------------------------------------------------------
    primary: ConsColors.greenBg,
    secondary: ConsColors.blueBg2,

    // ----------------------------------------------------------
    // Background
    // ----------------------------------------------------------
    background: ConsColors.lightBackground,
    surface: ConsColors.lightSurface,
    card: ConsColors.lightCard,

    // ----------------------------------------------------------
    // Text
    // ----------------------------------------------------------
    textPrimary: ConsColors.blue,
    textSecondary: ConsColors.gray,
    textDisabled: ConsColors.grayDisabled,

    // ----------------------------------------------------------
    // Border / Divider
    // ----------------------------------------------------------
    border: ConsColors.borderInactive,
    divider: ConsColors.dividerGreen,

    // ----------------------------------------------------------
    // Input
    // ----------------------------------------------------------
    inputBackground: ConsColors.lightInput,
    inputHint: ConsColors.gray,

    // ----------------------------------------------------------
    // Navigation
    // ----------------------------------------------------------
    navigationBackground: ConsColors.lightSurface,

    // ----------------------------------------------------------
    // App Bar / Buttons
    // ----------------------------------------------------------
    appBarBackground: ConsColors.blueBg2,
    appBarSecondary: ConsColors.blueBg1,
    backButtonBackground: ConsColors.lightSurface,
    backButtonStroke: ConsColors.borderActive,

    // ----------------------------------------------------------
    // Status
    // ----------------------------------------------------------
    success: ConsColors.success,
    warning: ConsColors.orange,
    warning2: ConsColors.orange2,
    warningBKProfile: ConsColors.yellowBKProfile,
    error: ConsColors.error,

    // ----------------------------------------------------------
    // Shadow
    // ----------------------------------------------------------
    shadow: ConsColors.shadow,
  );

  // ============================================================
  // DARK THEME
  // ============================================================

  static const dark = AppThemeColors(
    // ----------------------------------------------------------
    // Primary
    // ----------------------------------------------------------

    /// پس زمینه اصلی دکمه‌ها
    primary: ConsColors.darkPrimary,

    /// رنگ Active / Selected
    secondary: ConsColors.darkPrimaryActive,

    // ----------------------------------------------------------
    // Background
    // ----------------------------------------------------------

    /// #111513
    background: ConsColors.darkBackground,

    /// #111513
    surface: ConsColors.darkSurface,

    /// Card
    card: ConsColors.darkCard,

    // ----------------------------------------------------------
    // Text
    // ----------------------------------------------------------

    /// #FFFFFF
    textPrimary: ConsColors.darkTextPrimary,

    /// #767978
    textSecondary: ConsColors.darkTextSecondary,

    /// Disabled
    textDisabled: ConsColors.darkTextDisabled,

    // ----------------------------------------------------------
    // Border / Divider
    // ----------------------------------------------------------
    border: ConsColors.darkBorderInactive,
    divider: ConsColors.darkDivider,

    // ----------------------------------------------------------
    // Input
    // ----------------------------------------------------------

    /// #292C2B
    inputBackground: ConsColors.darkInput,
    inputHint: ConsColors.darkInputHint,

    // ----------------------------------------------------------
    // Navigation
    // ----------------------------------------------------------
    navigationBackground: ConsColors.darkNavigation,

    // ----------------------------------------------------------
    // App Bar / Buttons
    // ----------------------------------------------------------
    appBarBackground: ConsColors.darkAppBar,
    appBarSecondary: ConsColors.darkAppBarSecondary,
    backButtonBackground: ConsColors.darkBackButtonBackground,
    backButtonStroke: ConsColors.darkBackButtonStroke,

    // ----------------------------------------------------------
    // Status
    // ----------------------------------------------------------
    success: ConsColors.success,

    warning: ConsColors.darkPrimary,

    warning2: ConsColors.darkPrimaryActive,

    warningBKProfile: Color(0xFF442E2A),

    error: ConsColors.error,

    // ----------------------------------------------------------
    // Shadow
    // ----------------------------------------------------------
    shadow: ConsColors.darkShadow,
  );
}
