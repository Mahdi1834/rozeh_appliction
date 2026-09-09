import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.title, required this.onPressed , this.isBg= true});

  final String title;
  final VoidCallback onPressed;
  final bool isBg ;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 40, // 👈 همانند دکمه گرادینت
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10),
          foregroundColor: context.appColors.textPrimary,
          backgroundColor:isBg ? context.appColors.inputBackground : Colors.transparent,
          side: BorderSide(color: Colors.transparent),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title.toPersianDigit(),
          style: TextStyle(
            fontSize: 14, // 👈 هماهنگ با دکمه گرادینت
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
