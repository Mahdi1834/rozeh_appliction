import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/fancy_card_bottom_sheet.dart';


class CardForBottomSheet extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CardForBottomSheet({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // کارت اصلی
        SizedBox(width: width, child: FancyCardBottomSheet(child: child)),

        // دکمه بستن
        Positioned(
          top: -40,
          child: IgnorePointer(
            ignoring: false,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onPressed,
                child: Container(
                  width: 60, // بزرگتر برای لمس راحت‌تر
                  height: 60,
                  alignment: Alignment.center,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [ConsColors.orange2, ConsColors.orange],
                      ),
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

