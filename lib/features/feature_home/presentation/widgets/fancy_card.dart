import 'package:flutter/material.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/fancy_card_painter.dart';
class FancyCard extends StatelessWidget {
  final Widget child;

  const FancyCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FancyCardPainter(backgroundColor: Colors.white),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: child,
      ),
    );
  }
}
