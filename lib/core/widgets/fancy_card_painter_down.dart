import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';

class FancyCardPainterDown extends CustomPainter {
  final Color backgroundColor;
  final double dipWidth;
  FancyCardPainterDown( {required this.backgroundColor , this.dipWidth = 140,});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path();

    const radius = 20.0;      // شعاع گوشه‌ها
    // double dipWidth =  dipWidth;   // عرض تو رفتگی
    const dipHeight = 35.0;   // عمق تو رفتگی

    path.moveTo(0, radius);

    // گوشه بالا چپ گرد
    path.quadraticBezierTo(0, 0, radius, 0);

    // خط بالایی
    path.lineTo(size.width - radius, 0);

    // گوشه بالا راست گرد
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // خط سمت راست
    path.lineTo(size.width, size.height - radius);

    // گوشه پایین راست گرد
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

    // خط تا شروع تو رفتگی
    path.lineTo((size.width + dipWidth) / 2 + radius, size.height);

    // گوشه پایین راست تو رفتگی
    path.arcToPoint(
      Offset((size.width + dipWidth) / 2, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    // خط عمودی بالا تو رفتگی
    path.lineTo((size.width + dipWidth) / 2, size.height - dipHeight + radius);

    // گوشه بالا راست تو رفتگی
    path.arcToPoint(
      Offset((size.width + dipWidth) / 2 - radius, size.height - dipHeight),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // خط افقی بالای تو رفتگی
    path.lineTo((size.width - dipWidth) / 2 + radius, size.height - dipHeight);

    // گوشه بالا چپ تو رفتگی
    path.arcToPoint(
      Offset((size.width - dipWidth) / 2, size.height - dipHeight + radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // خط عمودی پایین تو رفتگی
    path.lineTo((size.width - dipWidth) / 2, size.height - radius);

    // گوشه پایین چپ تو رفتگی
    path.arcToPoint(
      Offset((size.width - dipWidth) / 2 - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    // ادامه پایین تا چپ کارت
    path.lineTo(radius, size.height);

    // گوشه پایین چپ گرد
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // سمت چپ
    path.lineTo(0, radius);

    path.close();

    // 🟠 اضافه کردن سایه نارنجی
    canvas.drawShadow(
      path,
      ConsColors.orange2.withValues(alpha: 0.5), // رنگ سایه با شفافیت
      2.0, // ضخامت سایه
      false, // برای نمایش یکنواخت دور تا دور، false باید باشه
    );



    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
