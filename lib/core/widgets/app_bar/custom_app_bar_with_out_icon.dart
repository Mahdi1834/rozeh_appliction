import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rozeh_project/core/config/colors.dart';

import 'package:rozeh_project/core/widgets/txt_header.dart';

class CustomAppBarWithOutIcon extends StatelessWidget {
  const CustomAppBarWithOutIcon({
    super.key,
    required this.mainContext,
    required this.title,
  });

  final BuildContext mainContext;
  final String title;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(minHeight: 80),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          colors: [ConsColors.blueBg2, ConsColors.blueBg1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              child: SvgPicture.asset(
                height: 120,

                "assets/images/logo_top_left.svg",
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              child: SvgPicture.asset(
                height: 120,
                "assets/images/logo_top_right.svg",
              ),
            ),
          ),

          SizedBox(
            width: width,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10 , top: 25),
              child: Center(child: TxtHeader(text: title)),
            ),
          ),
        ],
      ),
    );
  }
}
