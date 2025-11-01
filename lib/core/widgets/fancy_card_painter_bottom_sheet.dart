import 'package:flutter/material.dart';

class FancyCardPainterBottomSheet extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    const radius = 20.0;
    final waveWidth = 55.0;  // عرض موج
    final waveHeight = 25.0; // ارتفاع موج
    final dipCenterX = size.width / 2;

    // شروع از پایین چپ
    path.moveTo(0, size.height);

    // پایین
    path.lineTo(size.width, size.height);

    // راست
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);

    // تا قبل از موج
    path.lineTo(dipCenterX + waveWidth / 2, 0);

    // 🎯 موج مرکزی (یک بالا پایین)
    path.cubicTo(
      dipCenterX + waveWidth / 4, waveHeight,
      dipCenterX - waveWidth / 4, waveHeight,
      dipCenterX - waveWidth / 2, 0,
    );

    // ادامه‌ی لبه‌ی بالا
    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);

    // برگشت به پایین
    path.lineTo(0, size.height);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


