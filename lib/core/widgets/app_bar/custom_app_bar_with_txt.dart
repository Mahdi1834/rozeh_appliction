import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/custom_btn_icon_menu.dart';
import 'package:rozeh_project/core/widgets/txt_header.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

class CustomAppBarWithText extends StatelessWidget {
  const CustomAppBarWithText({
    super.key,
    required this.mainContext,
    required this.title,
    required this.text,
    this.text2 = "",
  });

  final BuildContext mainContext;
  final String title;
  final String text;
  final String text2;

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

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomBtnIconMenu(
                      onTap: () {
                        Scaffold.of(mainContext).openDrawer();
                      },
                      imageUrl: "assets/images/menu.svg",
                    ),
                    Expanded(child: Center(child: TxtHeader(text: title))),
                    SizedBox(
                      width: 40,
                    )


                  ],
                ),
                Divider(color: ConsColors.dividerGreen),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TxtTitle(text: text, color: Colors.white, size: 16),
                    SizedBox(width: 10,
                    height: 30,),
                    TxtTitle(text: text2, color: Colors.white, size: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
