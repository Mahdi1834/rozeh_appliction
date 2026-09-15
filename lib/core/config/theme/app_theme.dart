import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/config/theme/app_theme_colors.dart';

class MyThemes {
  MyThemes._();

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'IRANSansX',
    brightness: Brightness.light,

    extensions: [AppThemePalettes.light],

    // ==========================================================
    // Scaffold
    // ==========================================================
    scaffoldBackgroundColor: ConsColors.lightBackground,

    // ==========================================================
    // Color Scheme
    // ==========================================================
    colorScheme: const ColorScheme.light(
      primary: ConsColors.greenBg,
      secondary: ConsColors.blueBg2,

      surface: ConsColors.lightSurface,

      onPrimary: ConsColors.blue,
      onSecondary: ConsColors.blue,
      onSurface: ConsColors.blue,
    ),

    // ==========================================================
    // AppBar
    // ==========================================================
    appBarTheme: const AppBarTheme(
      backgroundColor: ConsColors.blueBg1,
      foregroundColor: ConsColors.blue,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),

    // ==========================================================
    // Card
    // ==========================================================
    cardTheme: CardThemeData(
      color: ConsColors.lightCard,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // ==========================================================
    // Input
    // ==========================================================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ConsColors.lightInput,

      hintStyle: const TextStyle(color: ConsColors.gray),

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

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.error, width: 1.5),
      ),
    ),

    // ==========================================================
    // Divider
    // ==========================================================
    dividerTheme: const DividerThemeData(
      color: ConsColors.dividerGreen,
      thickness: 1,
    ),

    // ==========================================================
    // Navigation Bar
    // ==========================================================
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ConsColors.lightSurface,
      elevation: 0,
      indicatorColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: ConsColors.green);
        }

        return const IconThemeData(color: ConsColors.gray);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: ConsColors.green);
        }

        return const TextStyle(color: ConsColors.gray);
      }),
    ),

    // ==========================================================
    // Time Picker
    // ==========================================================
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: ConsColors.lightSurface,

      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.blue),
      ),

      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.grey),
      ),

      dayPeriodColor: ConsColors.greenBg,
      dayPeriodTextColor: ConsColors.blue,

      dialHandColor: ConsColors.greenBg,

      hourMinuteColor: ConsColors.greenBg,
      hourMinuteTextColor: ConsColors.blue,

      helpTextStyle: TextStyle(color: ConsColors.blue),
    ),

    // ==========================================================
    // Date Picker
    // ==========================================================
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: ConsColors.greenBg,
      headerForegroundColor: ConsColors.blue,

      backgroundColor: ConsColors.lightSurface,

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

        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.hovered)) {
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

    // ==========================================================
    // Scaffold
    // ==========================================================
    scaffoldBackgroundColor: ConsColors.darkBackground,

    // ==========================================================
    // Color Scheme
    // ==========================================================
    colorScheme: const ColorScheme.dark(
      primary: ConsColors.darkPrimary,
      secondary: ConsColors.darkPrimaryActive,

      surface: ConsColors.darkSurface,

      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: ConsColors.darkTextPrimary,
    ),

    // ==========================================================
    // AppBar
    // ==========================================================
    appBarTheme: const AppBarTheme(
      backgroundColor: ConsColors.darkAppBar,
      foregroundColor: ConsColors.darkTextPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),

    // ==========================================================
    // Card
    // ==========================================================
    cardTheme: CardThemeData(
      color: ConsColors.darkCard,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // ==========================================================
    // Input
    // ==========================================================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ConsColors.darkInput,

      hintStyle: const TextStyle(color: ConsColors.darkInputHint),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.darkBorderInactive),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.darkBorderInactive),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: ConsColors.darkBorderActive,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ConsColors.error, width: 1.5),
      ),
    ),

    // ==========================================================
    // Divider
    // ==========================================================
    dividerTheme: const DividerThemeData(
      color: ConsColors.darkDivider,
      thickness: 1,
    ),

    // ==========================================================
    // Navigation Bar
    // ==========================================================
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ConsColors.darkNavigation,
      elevation: 0,

      // در طرح جدید آیتم انتخاب شده قرمز است
      indicatorColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: ConsColors.darkPrimaryActive);
        }

        return const IconThemeData(color: ConsColors.darkTextSecondary);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: ConsColors.darkPrimaryActive);
        }

        return const TextStyle(color: ConsColors.darkTextSecondary);
      }),
    ),

    // ==========================================================
    // Time Picker
    // ==========================================================
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: ConsColors.darkSurface,

      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.darkPrimaryActive),
      ),

      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.darkTextSecondary),
      ),

      dayPeriodColor: ConsColors.darkPrimary,
      dayPeriodTextColor: Colors.white,

      dialHandColor: ConsColors.darkPrimaryActive,

      hourMinuteColor: ConsColors.darkPrimary,
      hourMinuteTextColor: Colors.white,

      helpTextStyle: TextStyle(color: Colors.white),
    ),

    // ==========================================================
    // Date Picker
    // ==========================================================
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: ConsColors.darkPrimary,
      headerForegroundColor: Colors.white,

      backgroundColor: ConsColors.darkSurface,

      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.darkPrimaryActive;
        }

        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }

        return Colors.transparent;
      }),

      todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.darkPrimaryActive;
        }

        return Colors.transparent;
      }),

      yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.darkPrimaryActive;
        }

        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }

        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.hovered)) {
          return ConsColors.darkPrimary;
        }

        return Colors.transparent;
      }),

      surfaceTintColor: Colors.transparent,

      confirmButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.darkPrimaryActive),
      ),

      cancelButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.darkTextSecondary),
      ),
    ),
  );
}
