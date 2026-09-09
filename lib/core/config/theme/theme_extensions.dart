import 'package:flutter/material.dart';
import 'app_theme_colors.dart';
import 'app_theme_extension.dart';

extension ThemeContextExtension on BuildContext {
  AppThemeColors get appColors {
    final theme = Theme.of(this);

    return theme.extension<AppThemeColors>() ??
        (theme.brightness == Brightness.dark
            ? AppThemePalettes.dark
            : AppThemePalettes.light);
  }
}
