import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TxtWithAlign extends StatelessWidget {
  const TxtWithAlign({
    super.key,
    required this.text,
    required this.color,
    required this.size,
  });

  final String text;

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toPersianDigit(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
