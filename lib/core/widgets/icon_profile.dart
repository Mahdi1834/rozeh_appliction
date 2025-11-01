import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';

class IconProfile extends StatelessWidget {
  const IconProfile({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.12,
      width: width * 0.12,
      decoration: BoxDecoration(
          color: ConsColors.grayLight,
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Image.asset(
          "assets/images/profile.png",
          width :15,
          height: 15,
          color: ConsColors.blue,
        ),
      ),
    );
  }
}
