import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/fancy_card_down.dart';

class CardWithButtonInDip extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final String title;

  const CardWithButtonInDip({
    super.key,
    required this.child,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none, // اجازه خروج دکمه از کارت
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

            child: CustomBtnGradient(title: title, onPressed: onPressed),
          ),
        ),
      ],
    );
  }
}
