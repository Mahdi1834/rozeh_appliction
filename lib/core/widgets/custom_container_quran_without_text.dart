import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomContainerQuranWithoutText extends StatelessWidget {
  const CustomContainerQuranWithoutText({
    super.key, required this.widget,


  });

  final Widget widget;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/images/border_quran.svg', // مسیر فایل SVG
            fit: BoxFit.fill, // یا BoxFit.fill / BoxFit.contain
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child:widget ,
        ),
      ],
    );
  }
}
