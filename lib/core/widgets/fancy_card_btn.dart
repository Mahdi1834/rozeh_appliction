import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/fancy_card_painter2.dart';

class FancyCardBtn extends StatelessWidget {
  final Widget child;

  const FancyCardBtn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
      painter: FancyCardPainter2(
        backgroundGradient: LinearGradient(
          colors: [ConsColors.orange, ConsColors.orange2],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Center(child: child),
    );
  }
}
