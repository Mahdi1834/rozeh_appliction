import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/config/theme/app_theme_colors.dart';

class MyThemes {
  // ============================================================
  // LIGHT THEME
  // ============================================================

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'IRANSansX',
    brightness: Brightness.light,
    extensions: const [AppThemePalettes.light],

    scaffoldBackgroundColor: Colors.white,

    colorScheme: ColorScheme.light(
      primary: ConsColors.blueBg2,
      secondary: ConsColors.green,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: ConsColors.blue,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: ConsColors.blueBg1,
      foregroundColor: ConsColors.blue,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ConsColors.blueLight,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.borderInactive),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.borderInactive),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: ConsColors.borderActive,
          width: 1.5,
        ),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: ConsColors.dividerGreen,
      thickness: 1,
    ),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,

      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.blue),
      ),

      cancelButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.grey),
      ),

      dayPeriodColor: ConsColors.greenBg,
      dayPeriodTextColor: ConsColors.blue,

      dialHandColor: ConsColors.greenBg,

      hourMinuteColor: ConsColors.greenBg,
      hourMinuteTextColor: ConsColors.blue,

      helpTextStyle: const TextStyle(color: ConsColors.blue),
    ),

    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: ConsColors.greenBg,
      headerForegroundColor: ConsColors.blue,

      backgroundColor: Colors.white,

      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.greenBg;
        }

        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }

        return Colors.transparent;
      }),

      todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.greenBg;
        }

        return Colors.transparent;
      }),

      yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.greenBg;
        }

        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }

        if (states.contains(WidgetState.focused)) {
          return ConsColors.blueLight;
        }

        if (states.contains(WidgetState.hovered)) {
          return ConsColors.blueLight;
        }

        return Colors.transparent;
      }),

      surfaceTintColor: Colors.transparent,

      confirmButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.blue),
      ),

      cancelButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.grey),
      ),
    ),
  );

  // ============================================================
  // DARK THEME
  // ============================================================

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'IRANSansX',
    brightness: Brightness.dark,
    extensions: const [AppThemePalettes.dark],

    scaffoldBackgroundColor: const Color(0xFF071E24),

    colorScheme: const ColorScheme.dark(
      primary: ConsColors.blueBg2,
      secondary: ConsColors.greenBg,

      surface: Color(0xFF0D2A31),

      onPrimary: Colors.white,
      onSecondary: Color(0xFF071E24),
      onSurface: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF08272E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: Color(0xFF0D2A31),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF12353D),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF35636A)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF35636A)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.greenBg, width: 1.5),
      ),

      hintStyle: const TextStyle(color: Color(0xFF9AB2B7)),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xFF285159),
      thickness: 1,
    ),

    timePickerTheme: const TimePickerThemeData(
      backgroundColor: Color(0xFF0D2A31),

      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.greenBg),
      ),

      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Color(0xFFB0BEC5)),
      ),

      dayPeriodColor: Color(0xFF164B51),
      dayPeriodTextColor: Colors.white,

      dialHandColor: ConsColors.greenBg,

      hourMinuteColor: Color(0xFF164B51),
      hourMinuteTextColor: Colors.white,

      helpTextStyle: TextStyle(color: Colors.white),
    ),

    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: Color(0xFF164B51),
      headerForegroundColor: Colors.white,

      backgroundColor: Color(0xFF0D2A31),

      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.green;
        }

        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }

        return Colors.transparent;
      }),

      todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.green;
        }

        return Colors.transparent;
      }),

      yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.green;
        }

        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }

        if (states.contains(WidgetState.focused)) {
          return Color(0xFF164B51);
        }

        if (states.contains(WidgetState.hovered)) {
          return Color(0xFF164B51);
        }

        return Colors.transparent;
      }),

      surfaceTintColor: Colors.transparent,

      confirmButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.greenBg),
      ),

      cancelButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Color(0xFFB0BEC5)),
      ),
    ),
  );
}
