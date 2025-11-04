import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TxtTitleNotBold extends StatelessWidget {
  const TxtTitleNotBold({
    super.key,
    required this.text,
    required this.color,
    this.size = 14,
     this.textAlign = TextAlign.start,
  });

  final String text;
  final Color color;
  final double size;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toPersianDigit(),
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: size),
    );
  }
}
