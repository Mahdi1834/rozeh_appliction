import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
class TxtForQuran extends StatelessWidget {
  const TxtForQuran({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toPersianDigit(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ConsColors.green,
        fontSize: 14,
        // wordSpacing: 2,
        height: 2,

        fontWeight: FontWeight.bold,
      ),
    );
  }
}