import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';

class CustomBtnGradient extends StatelessWidget {
  const CustomBtnGradient({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // 👈 اضافه شد
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // 👈 حذف padding اضافی
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ConsColors.greenBg, ConsColors.greenBg],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ConsColors.greenBg),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14, // 👈 برابر با دکمه‌ی معمولی
                fontWeight: FontWeight.bold,
                color: ConsColors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

