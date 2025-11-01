import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn({
    super.key,
    required this.onPressed,
    this.useGradient = true,
    required this.title,
  });

  final VoidCallback onPressed;
  final bool useGradient;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(

          padding: EdgeInsets.symmetric(horizontal: 12),
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          // فقط برای backup
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient:
                useGradient
                    ? LinearGradient(
                      colors: [ConsColors.orange2, ConsColors.orange],
                    )
                    : null,
            color: useGradient ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 35,
            child: Row(
              children: [
                Expanded(
                  child: TxtTitle(
                    size: 12,
                    text: title,
                    color: useGradient ? Colors.white : ConsColors.orange,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: useGradient ? Colors.white : ConsColors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
