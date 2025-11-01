import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/fancy_card_painter_down.dart';

class FancyCardDown extends StatelessWidget {
  final Widget child;
  final double dipWidth;
  const FancyCardDown({super.key, required this.child, required this.dipWidth});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FancyCardPainterDown(backgroundColor: Colors.white , dipWidth: dipWidth),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: child,
      ),
    );
  }
}
