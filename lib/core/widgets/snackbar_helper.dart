import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

/// 🔹 کلاس واحد برای نمایش SnackBar از هرجای پروژه
class SnackbarHelper {
  /// [context]: BuildContext فعلی
  /// [message]: پیام اصلی
  /// [status]: نوع پیام (موفقیت، خطا، اطلاع)
  /// [duration]: مدت زمان نمایش
  static void show({
    required BuildContext context,
    required String message,
    SnackbarStatus status = SnackbarStatus.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    late Widget snack;

    switch (status) {
      case SnackbarStatus.success:
        snack = CustomSnackBar.success(
          message: message,
          backgroundColor:  ConsColors.green, // سبز موفقیت

          textStyle: const TextStyle(
            fontFamily: 'IRANSansX',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        );
        break;

      case SnackbarStatus.error:
        snack = CustomSnackBar.error(
          message: message,
          backgroundColor: const Color(0xFFE74C3C), // قرمز خطا
          textStyle: const TextStyle(
            fontFamily: 'IRANSansX',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        );
        break;

      case SnackbarStatus.info:
        snack = CustomSnackBar.info(

          message: message,
          backgroundColor: ConsColors.blue, // آبی اطلاع
          textStyle: const TextStyle(
            fontFamily: 'IRANSansX',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        );
        break;
    }

    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay != null) {
      showTopSnackBar(
        overlay,
        snack,
        animationDuration: const Duration(milliseconds: 600),
        displayDuration: duration,
      );
    } else {
      debugPrint("⚠️ No overlay found to show snackbar.");
    }
  }
}

/// 🔸 وضعیت‌های مختلف Snackbar
enum SnackbarStatus { success, error, info }
