import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TxtHeader extends StatelessWidget {
  const TxtHeader({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toPersianDigit(),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
