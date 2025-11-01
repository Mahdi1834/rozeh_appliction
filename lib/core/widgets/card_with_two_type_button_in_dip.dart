import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/custom_btn.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/fancy_card_down.dart';

class CardWithTwoTypeButtonInDip extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final String title;
  final String title2;
  final bool isPrimary; // 🔹 نوع دکمه را کنترل می‌کند

  const CardWithTwoTypeButtonInDip({
    super.key,
    required this.child,
    required this.onPressed,
    required this.title,
    required this.title2,
    this.isPrimary = true, // مقدار پیش‌فرض: دکمه اصلی
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    // ✅ بر اساس مقدار isPrimary ویجت مناسب انتخاب کن
    final Widget button =
        isPrimary
            ? CustomBtnGradient(title: title, onPressed: onPressed)
            : CustomBtn(title: title2, onPressed: onPressed);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: width,
          child: FancyCardDown(dipWidth: width * 0.6, child: child),
        ),
        Positioned(
          bottom: -15,
          child: SizedBox(
            width: width * 0.55,
            child: button, // 🔹 دکمه نهایی بر اساس isPrimary
          ),
        ),
      ],
    );
  }
}
