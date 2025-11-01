import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TxtMedium extends StatelessWidget {
  const TxtMedium({
    super.key,
    required this.text,
    this.isAlignCenter = false,
    this.sizeText = 14,
  });

  final String text;
  final bool isAlignCenter;
  final double sizeText;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toPersianDigit(),
      textAlign: isAlignCenter ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: ConsColors.blue,
        fontSize: sizeText,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}