import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: ConsColors.grayLight,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}