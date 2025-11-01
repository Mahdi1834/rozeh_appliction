import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;

  const NavButton({
    super.key,
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // final desiredPosition = 1.0 / length * index;
    // final difference = (position - desiredPosition).abs();
    // final verticalAlignment = 1 - length * difference;
    // final opacity = 1.0 - (difference * 2).clamp(0.0, 0.4);
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
            height: 75.0,
            child: child),
      ),
    );
  }
}
