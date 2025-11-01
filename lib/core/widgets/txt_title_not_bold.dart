import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';


class TxtTitleNotBold extends StatelessWidget {
  const TxtTitleNotBold({super.key, required this.text, required this.color,  this.size = 14});

  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toPersianDigit(),
      style: TextStyle(color: color, fontSize: size),
    );
  }
}