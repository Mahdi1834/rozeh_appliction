import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/fancy_card_painter_bottom_sheet.dart';

class FancyCardBottomSheet extends StatelessWidget {
  final Widget child;
  const FancyCardBottomSheet({super.key, required this.child,});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FancyCardPainterBottomSheet(),
      child: Container(
        // margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
        child: child,
      ),
    );
  }
}
