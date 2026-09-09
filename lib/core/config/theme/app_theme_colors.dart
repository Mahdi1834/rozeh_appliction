import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'app_theme_extension.dart';

class AppThemePalettes {
  AppThemePalettes._();

  static const light = AppThemeColors(
    primary: ConsColors.blue,
    secondary: ConsColors.greenBg,

    background: Colors.white,
    surface: Colors.white,
    card: Colors.white,

    textPrimary: ConsColors.blue,
    textSecondary: ConsColors.gray,
    textDisabled: Color(0xFFB8C2C8),

    border: ConsColors.borderInactive,
    divider: ConsColors.dividerGreen,

    inputBackground: Color(0xFFF6FAFA),

    navigationBackground: Colors.white,

    success: ConsColors.green,
    warning: ConsColors.orange,
    warning2: ConsColors.orange2,
    warningBKProfile: ConsColors.yellowBKProfile,
    error: Colors.red,

    shadow: ConsColors.shadow,
  );

  static const dark = AppThemeColors(
    primary: ConsColors.greenBg,
    secondary: ConsColors.blueBg2,

    background: Color(0xFF07191B),
    surface: Color(0xFF0B2225),
    card: Color(0xFF10292B),

    textPrimary: Colors.white,
    textSecondary: Color(0xFFB5C6C8),
    textDisabled: Color(0xFF617578),

    border: Color(0xFF1E4043),
    divider: Color(0xFF1B3D3F),

    inputBackground: Color(0xFF10292B),

    navigationBackground: Color(0xFF0B2225),

    success: ConsColors.greenBg,
    warning: Color(0xFFFFC46B),
    warning2: Color(0xFFF7A33E),
    warningBKProfile: Color(0xFFCCE7DC),
    error: Colors.redAccent,

    shadow: Colors.black54,
  );
}
