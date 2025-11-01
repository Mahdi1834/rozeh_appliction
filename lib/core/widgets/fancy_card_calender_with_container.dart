import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/top_left_cut_painter.dart';


class FancyCardCalenderWithContainer extends StatelessWidget {
  final Widget child;
  final Widget child2;
  final double cutWidth; 
  const FancyCardCalenderWithContainer({
    super.key,
    required this.child,
    required this.child2,
    required this.cutWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TopLeftCutPainter(
        cutWidth: cutWidth,
        cutHeight: 60,

        backgroundColor: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -10,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              width: cutWidth,
              height: 70,
              child: child2,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(
              top: 5,
              left: 5,
              right: 5,
              bottom: 10,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
