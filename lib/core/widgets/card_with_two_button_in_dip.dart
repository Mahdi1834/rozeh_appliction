import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/custom_btn.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/fancy_card_down.dart';

class CardWithTwoButtonInDip extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressedNext;
  final VoidCallback onPressedBack;
  final String nextTitle;
  final String backTitle;

  const CardWithTwoButtonInDip({
    super.key,
    required this.child,
    required this.onPressedNext,
    required this.onPressedBack,
    required this.nextTitle,
    required this.backTitle,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: width,
          child: FancyCardDown(dipWidth: width * 0.8, child: child),
        ),
        Positioned(
          bottom: -15,
          child: SizedBox(
            width: width * 0.75,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: CustomBtn(
                      title: backTitle,
                      onPressed: onPressedBack,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: CustomBtnGradient(
                      title: nextTitle,
                      onPressed: onPressedNext,
                    ),
                  ),
                ),

                // فاصله بین دکمه‌ها
              ],
            ),
          ),
        ),
      ],
    );
  }
}
