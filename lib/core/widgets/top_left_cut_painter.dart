import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';

class TopLeftCutPainter extends CustomPainter {
  final Color backgroundColor;
  final double cutWidth;
  final double cutHeight;

  TopLeftCutPainter({
    required this.backgroundColor,
    this.cutWidth = 120,
    this.cutHeight = 50,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    const radius = 16.0;
    final path = Path();
    final cutRadius = 30.0;

    // شروع از بالا سمت چپ
    path.moveTo(0, 0);

    // برش مستقیم از بالا به پایین
    // از بالا سمت چپ به پایین با گوشه گرد
    path.lineTo(0, cutHeight + cutRadius);
    path.quadraticBezierTo(0, cutHeight, cutRadius, cutHeight);

// از سمت چپ به راست با گوشه گرد
    path.lineTo(cutWidth - cutRadius, cutHeight);
    path.quadraticBezierTo(cutWidth, cutHeight, cutWidth, cutHeight - cutRadius);

// از پایین به بالا با گوشه گرد
    path.lineTo(cutWidth, cutRadius);
    path.quadraticBezierTo(cutWidth, 0, cutWidth + cutRadius, 0);

    // ادامه بالا تا گوشه بالا راست
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // راست
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

    // پایین
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // چپ
    path.lineTo(0, cutHeight);

    path.close();
    canvas.drawShadow(
      path,
      ConsColors.orange2.withValues(alpha:0.5), // رنگ سایه با شفافیت
      2.0, // ضخامت سایه
      false, // برای نمایش یکنواخت دور تا دور، false باید باشه
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TopLeftCutPainter oldDelegate) {
    return backgroundColor != oldDelegate.backgroundColor ||
        cutWidth != oldDelegate.cutWidth ||
        cutHeight != oldDelegate.cutHeight;
  }
}
