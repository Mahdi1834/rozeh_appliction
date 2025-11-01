import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TxtTitle extends StatelessWidget {
  const TxtTitle({
    super.key,
    required this.text,
    required this.color,
    this.size = 14,
    this.isAlignCenter = false,
  });

  final String text;
  final Color color;
  final double size;
  final bool isAlignCenter;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: isAlignCenter ? TextAlign.center : TextAlign.start,
      text.toPersianDigit(),
      style: TextStyle(

        color: color,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}

class TxtTitleForNumberPhone extends StatelessWidget {
  const TxtTitleForNumberPhone({
    super.key,
    required this.text,
    required this.color,
    this.size = 14,
    this.isAlignCenter = false,
  });

  final String text;
  final Color color;
  final double size;
  final bool isAlignCenter;

  @override
  Widget build(BuildContext context) {
    return Text(
      textDirection: TextDirection.ltr,
      textAlign: isAlignCenter ? TextAlign.center : TextAlign.start,
      text.toPersianDigit(),
      style: TextStyle(

        color: color,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}

