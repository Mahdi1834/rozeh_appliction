import 'package:flutter/material.dart';

class FancyCardPainter extends CustomPainter {
  final Color backgroundColor;
  FancyCardPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path();

    const radius = 20.0;      // شعاع گوشه‌ها
    const dipWidth = 140.0;   // عرض تو رفتگی
    const dipHeight = 35.0;   // عمق تو رفتگی

    path.moveTo(0, radius);

    // گوشه بالا چپ گرد
    path.quadraticBezierTo(0, 0, radius, 0);

    // خط تا شروع تو رفتگی
    path.lineTo((size.width - dipWidth) / 2 - radius, 0);

    // گوشه بالا چپ تو رفتگی (رادیوس)
    path.arcToPoint(
      Offset((size.width - dipWidth) / 2, radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    // خط عمودی پایین تو رفتگی
    path.lineTo((size.width - dipWidth) / 2, dipHeight - radius);

    // گوشه پایین چپ تو رفتگی (رادیوس)
    path.arcToPoint(
      Offset((size.width - dipWidth) / 2 + radius, dipHeight),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // خط افقی پایین تو رفتگی
    path.lineTo((size.width + dipWidth) / 2 - radius, dipHeight);

    // گوشه پایین راست تو رفتگی (رادیوس)
    path.arcToPoint(
      Offset((size.width + dipWidth) / 2, dipHeight - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // خط عمودی بالا تو رفتگی
    path.lineTo((size.width + dipWidth) / 2, radius);

    // گوشه بالا راست تو رفتگی (رادیوس)
    path.arcToPoint(
      Offset((size.width + dipWidth) / 2 + radius, 0),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    // ادامه خط بالای کارت تا گوشه بالا راست
    path.lineTo(size.width - radius, 0);

    // گوشه بالا راست گرد
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // راست کارت (خط عمودی)
    path.lineTo(size.width, size.height - radius);

    // گوشه پایین راست گرد
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

    // پایین کارت (خط افقی)
    path.lineTo(radius, size.height);

    // گوشه پایین چپ گرد
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // خط سمت چپ (عمودی) تا نقطه شروع
    path.lineTo(0, radius);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
