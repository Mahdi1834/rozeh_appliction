import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:rozeh_project/core/config/colors.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.light;
//
//   bool get isDarkMode => themeMode == ThemeMode.dark;
//
//   void toggleTheme() {
//     themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }
//
// class MyThemes {
//   static final darkTheme = ThemeData(
//     useMaterial3: true,
//     fontFamily: 'IRANSansX',
//     timePickerTheme: TimePickerThemeData(
//
//
//     ),
//     datePickerTheme: DatePickerThemeData(
//       headerBackgroundColor: context.appColors.success,
//       // Header background color
//       backgroundColor: Colors.white,
//       dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
//         Set<WidgetState> states,
//       ) {
//         if (states.contains(WidgetState.selected)) {
//           return context.appColors.inputBackground; // Background color for selected day
//         } else if (states.contains(WidgetState.disabled)) {
//           return Colors.transparent; // Background color for disabled days
//         }
//         return Colors.transparent; // Default background color for normal days
//       }),
//
//       yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
//         Set<WidgetState> states,
//       ) {
//         if (states.contains(WidgetState.selected)) {
//           return context.appColors.inputBackground; // Background color for selected day
//         } else if (states.contains(WidgetState.disabled)) {
//           return Colors.red; // Background color for disabled days
//         }
//         return Colors.transparent; // Default background color for normal days
//       }),
//
//       // weekdayStyle: TextStyle(color: context.appColors.textPrimary ,),
//       surfaceTintColor: Colors.red,
//
//       confirmButtonStyle: ButtonStyle(
//         textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.red)),
//       ),
//       headerForegroundColor: context.appColors.textPrimary,
//     ),
//   );
//
//   static final lightTheme = ThemeData(
//     useMaterial3: true,
//     fontFamily: 'IRANSansX',
//     timePickerTheme: TimePickerThemeData(
//
//
//       // 🔹 تغییر رنگ دکمه تایید
//       confirmButtonStyle: ButtonStyle(
//         foregroundColor: WidgetStatePropertyAll(context.appColors.textPrimary), // رنگ متن
//         // backgroundColor: WidgetStatePropertyAll(context.appColors.successLight), // رنگ پس‌زمینه
//       ),
//
//       // 🔹 تغییر رنگ دکمه لغو
//       cancelButtonStyle: ButtonStyle(
//         foregroundColor: WidgetStatePropertyAll(Colors.grey), // رنگ متن
//         // backgroundColor: WidgetStatePropertyAll(Colors.red), // رنگ پس‌زمینه
//       ),
//
//       dayPeriodColor:context.appColors.secondary,
//
//       dayPeriodTextColor:context.appColors.textPrimary,
//       dialHandColor: context.appColors.secondary,
//       hourMinuteColor: context.appColors.secondary,
//
//       hourMinuteTextColor: context.appColors.textPrimary,
//       helpTextStyle: TextStyle(color: context.appColors.textPrimary)// متن ساعت انتخاب شده
//
//
//
//
//     ),
//     datePickerTheme: DatePickerThemeData(
//       headerBackgroundColor: context.appColors.secondary,
//       // Header background color
//       backgroundColor: Colors.white,
//       dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
//         Set<WidgetState> states,
//       ) {
//         if (states.contains(WidgetState.selected)) {
//           return context.appColors.secondary; // Background color for selected day
//         } else if (states.contains(WidgetState.disabled)) {
//           return Colors.transparent; // Background color for disabled days
//         }
//         return Colors.transparent; // Default background color for normal days
//       }),
//       todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
//           Set<WidgetState> states,
//           ) {
//         if (states.contains(WidgetState.selected)) {
//           return context.appColors.secondary; // Background color for selected day
//         } else if (states.contains(WidgetState.disabled)) {
//           return Colors.transparent; // Background color for disabled days
//         }
//         return Colors.transparent; // Default background color for normal days
//       }),
//
//       yearBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
//         Set<WidgetState> states,
//       ) {
//         if (states.contains(WidgetState.selected)) {
//           return context.appColors.secondary; // Background color for selected day
//         } else if (states.contains(WidgetState.disabled)) {
//           return Colors.red; // Background color for disabled days
//         } else if (states.contains(WidgetState.focused)) {
//           return context.appColors.inputBackground; // ✅ سال فعلی (امسال)
//         } else if (states.contains(WidgetState.hovered)) {
//           return context.appColors.inputBackground; // ✅ سال فعلی (امسال)
//         }
//         return Colors.transparent; // Default background color for normal days
//       }),
//
//       // weekdayStyle: TextStyle(color: context.appColors.textPrimary ,),
//       surfaceTintColor: Colors.purple,
//
//       headerForegroundColor: context.appColors.textPrimary,
//
//       // 🔹 تغییر رنگ دکمه تایید
//       confirmButtonStyle: ButtonStyle(
//         foregroundColor: WidgetStatePropertyAll(context.appColors.textPrimary), // رنگ متن
//         // backgroundColor: WidgetStatePropertyAll(context.appColors.successLight), // رنگ پس‌زمینه
//       ),
//
//       // 🔹 تغییر رنگ دکمه لغو
//       cancelButtonStyle: ButtonStyle(
//         foregroundColor: WidgetStatePropertyAll(Colors.grey), // رنگ متن
//         // backgroundColor: WidgetStatePropertyAll(Colors.red), // رنگ پس‌زمینه
//       ),
//     ),
//   );
// }
