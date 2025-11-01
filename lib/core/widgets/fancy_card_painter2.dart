import 'package:flutter/material.dart';

class FancyCardPainter2 extends CustomPainter {
  final Gradient backgroundGradient;

  FancyCardPainter2({required this.backgroundGradient});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = backgroundGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    const radius = 20.0;
    final dipRadius = 15.0;
    final dipCenterX = size.width / 2;

    // شروع از بالا چپ
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    // بالا
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // راست
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

    // شروع موج U شکل - یک منحنی ساده

    path.lineTo(dipCenterX + dipRadius, size.height);

    // یک منحنی cubic ساده بین دو طرف U شکل
    path.cubicTo(
      dipCenterX + dipRadius * 0.3, size.height - dipRadius * 0.6,
      dipCenterX - dipRadius * 0.3, size.height - dipRadius * 0.6,
      dipCenterX - dipRadius, size.height,
    );

    // ادامه تا چپ
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.close();
    canvas.drawPath(path, paint);
  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
