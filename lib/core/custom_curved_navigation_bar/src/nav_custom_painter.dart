import 'package:flutter/material.dart';

class NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(
      double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.08; // 👈 کوچکتر شدن محدوده‌ی گودی
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.92- l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 10)
      ..quadraticBezierTo(0, 0, 10, 0)
      ..lineTo((loc - 0.05) * size.width, 0) // 👈 عرض قبل از گودی کمتر شد
      ..cubicTo(
        (loc + s * 0.10) * size.width,
        size.height * 0.01, // 👈 ارتفاع کمتر
        loc * size.width,
        size.height * 0.10, // 👈 ارتفاع گودی کمتر شد
        (loc + s * 0.50) * size.width,
        size.height * 0.10,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.10,
        (loc + s - s * 0.10) * size.width,
        size.height * 0.01,
        (loc + s + 0.05) * size.width,
        0,
      )
      ..lineTo(size.width - 10, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 10)
      ..lineTo(size.width, size.height - 10)
      ..quadraticBezierTo(size.width, size.height, size.width - 10, size.height)
      ..lineTo(10, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 10)
      ..close();

    // سایه
    // canvas.drawShadow(path, Colors.black.withOpacity(0.3), 6.0, true);
    // 🔥 سایه‌ی نارنجی اطراف کل مسیر
    final glowPaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawPath(path, glowPaint); // سایه

    // رنگ پر
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // // رنگ حاشیه
    // final strokePaint = Paint()
    //   ..color = Colors.orange
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 1;
    //
    // canvas.drawPath(path, strokePaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // همیشه repaint بشه اگر موقعیت عوض بشه
  }
}
