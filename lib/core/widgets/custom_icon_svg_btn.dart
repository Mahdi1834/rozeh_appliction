import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomSvgIconBtn extends StatelessWidget {
  const CustomSvgIconBtn({
    super.key,
    required this.onPressed,
    this.useGradient = true,
    required this.title, required this.svgPicture,
  });

  final VoidCallback onPressed;
  final bool useGradient;
  final String title;
  final String svgPicture;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // 👈 همانند دکمه گرادینت
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10),
          foregroundColor: ConsColors.orange,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: ConsColors.orange),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text(
              title.toPersianDigit(),
              style: TextStyle(
                fontSize: 14, // 👈 هماهنگ با دکمه گرادینت
                fontWeight: FontWeight.bold,
              ),
            ),
            SvgPicture.asset(svgPicture),
          ],
        ),
      ),
    );
  }
}
