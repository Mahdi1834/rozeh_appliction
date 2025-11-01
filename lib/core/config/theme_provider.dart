import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'IRANSansX',
    timePickerTheme: TimePickerThemeData(


    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: ConsColors.blueLight,
      // Header background color
      backgroundColor: Colors.white,
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.blueLight; // Background color for selected day
        } else if (states.contains(WidgetState.disabled)) {
          return Colors.transparent; // Background color for disabled days
        }
        return Colors.transparent; // Default background color for normal days
      }),

      yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.blueLight; // Background color for selected day
        } else if (states.contains(WidgetState.disabled)) {
          return Colors.red; // Background color for disabled days
        }
        return Colors.transparent; // Default background color for normal days
      }),

      // weekdayStyle: TextStyle(color: ConsColors.blue ,),
      surfaceTintColor: Colors.red,

      confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
      ),
      headerForegroundColor: ConsColors.blue,
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'IRANSansX',
    timePickerTheme: TimePickerThemeData(


      // 🔹 تغییر رنگ دکمه تایید
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.blue), // رنگ متن
        // backgroundColor: WidgetStatePropertyAll(ConsColors.greenLight), // رنگ پس‌زمینه
      ),

      // 🔹 تغییر رنگ دکمه لغو
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.grey), // رنگ متن
        // backgroundColor: WidgetStatePropertyAll(Colors.red), // رنگ پس‌زمینه
      ),

      dayPeriodColor:ConsColors.blueLight,

      dayPeriodTextColor:ConsColors.blue,
      dialHandColor: ConsColors.blueLight,
      hourMinuteColor: ConsColors.blueLight,

      hourMinuteTextColor: ConsColors.blue,
      helpTextStyle: TextStyle(color: ConsColors.blue)// متن ساعت انتخاب شده




    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: ConsColors.blueLight,
      // Header background color
      backgroundColor: Colors.white,
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.blueLight; // Background color for selected day
        } else if (states.contains(WidgetState.disabled)) {
          return Colors.transparent; // Background color for disabled days
        }
        return Colors.transparent; // Default background color for normal days
      }),
      todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
          ) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.blueLight; // Background color for selected day
        } else if (states.contains(WidgetState.disabled)) {
          return Colors.transparent; // Background color for disabled days
        }
        return Colors.transparent; // Default background color for normal days
      }),

      yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return ConsColors.blueLight; // Background color for selected day
        } else if (states.contains(WidgetState.disabled)) {
          return Colors.red; // Background color for disabled days
        } else if (states.contains(WidgetState.focused)) {
          return ConsColors.blueLight; // ✅ سال فعلی (امسال)
        } else if (states.contains(WidgetState.hovered)) {
          return ConsColors.blueLight; // ✅ سال فعلی (امسال)
        }
        return Colors.transparent; // Default background color for normal days
      }),

      // weekdayStyle: TextStyle(color: ConsColors.blue ,),
      surfaceTintColor: Colors.red,

      headerForegroundColor: ConsColors.blue,

      // 🔹 تغییر رنگ دکمه تایید
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ConsColors.blue), // رنگ متن
        // backgroundColor: WidgetStatePropertyAll(ConsColors.greenLight), // رنگ پس‌زمینه
      ),

      // 🔹 تغییر رنگ دکمه لغو
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.grey), // رنگ متن
        // backgroundColor: WidgetStatePropertyAll(Colors.red), // رنگ پس‌زمینه
      ),
    ),
  );
}
