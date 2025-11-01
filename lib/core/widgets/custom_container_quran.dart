import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/widgets/txt_for_quran_blue.dart';

class CustomContainerQuran extends StatelessWidget {
  const CustomContainerQuran({
    super.key,
    required this.text,
    this.height = 2,
    this.fontSize = 14,
    this.wordSpacing = 2, required this.isOdd,
  });
  final bool isOdd;
  final String text;
  final double height;
  final double fontSize;
  final double wordSpacing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            isOdd ? "assets/images/border_odd.svg" : 'assets/images/border_even.svg', // مسیر فایل SVG
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: TxtForQuranBlue(
              text: text,
              fontSize: fontSize,
              height: height,
              wordSpacing: wordSpacing,
            ),
          ),
        ),
      ],
    );
  }
}
