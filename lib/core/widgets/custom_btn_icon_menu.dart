import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBtnIconMenu extends StatelessWidget {
  const CustomBtnIconMenu({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // شفاف یا رنگی که می‌خوای
      borderRadius: BorderRadius.circular(12), // گوشه‌ها مثل Container
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        // مهم برای انیمیشن موج
        splashColor: Colors.white.withValues(alpha: 0.3),
        // موج هنگام کلیک
        highlightColor: Colors.white.withValues(alpha: 0.1),
        // نور لحظه‌ای
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SvgPicture.asset(
              imageUrl,

              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 25,
              height: 25,
            ),
          ),
        ),
      ),
    );
  }
}
