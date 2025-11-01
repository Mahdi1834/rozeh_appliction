import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/txt_medium.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:progress_border/progress_border.dart';

class ProgressBox extends StatelessWidget {
  final int currentValue;
  final int maxValue;

  const ProgressBox({
    required this.currentValue,
    this.maxValue = 100,
    super.key,
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
      child: Row(
        children: [
          Expanded(
            child: TxtMedium(
              sizeText: 12,
              text:
                  "مدت زمان لازم برای انجام برنامه امروز $maxValue دقیقه است.",

            ),
          ),
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [ConsColors.orange2, ConsColors.orange],
                  ),
                ),
                child: SvgPicture.asset(
                  width: 15,
                  height: 15,
                  color: Colors.white,
                  "assets/images/timer.svg",
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  TxtTitle(text: currentValue.toString(), color: ConsColors.orange, size: 12),
                  TxtTitle(text: " دقیقه", color: ConsColors.blue, size: 12),
                ],
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
