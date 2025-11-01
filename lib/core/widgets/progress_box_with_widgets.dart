import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:progress_border/progress_border.dart';

class ProgressBoxWithWidgets extends StatelessWidget {
  final double currentValue;
  final double maxValue;
  final Widget widget;

  const ProgressBoxWithWidgets({
    required this.currentValue,
    this.maxValue = 100,
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double progress = currentValue / maxValue;

    return Container(
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: ProgressBorder.all(
          color: ConsColors.greenLight,
          width: 3,
          progress: progress.clamp(0.0, 1.0), // جلوگیری از overflow
          backgroundColor: ConsColors.yellowLight,
        ),
      ),
      child: widget,
    );
  }
}
