import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/fancy_card_painter2.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class FancyCardBtn extends StatelessWidget {
  final Widget child;

  const FancyCardBtn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
      painter: FancyCardPainter2(
        backgroundGradient: LinearGradient(
          colors: [context.appColors.warning, context.appColors.warning2],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Center(child: child),
    );
  }
}
