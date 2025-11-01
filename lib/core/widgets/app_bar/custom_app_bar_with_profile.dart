import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/custom_btn_icon_menu.dart';
import 'package:rozeh_project/core/widgets/txt_header.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

class CustomAppBarWithProfile extends StatelessWidget {
  const CustomAppBarWithProfile({
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
                    CustomBtnIconMenu(
                      onTap: () {
                        context.pop();
                      },
                      imageUrl: "assets/images/arrow_left.svg",
                    ),
                  ],
                ),
                Divider(color: ConsColors.dividerGreen),
                Row(
                  children: [
                    Container(
                      width: width * 0.15,
                      height: width * 0.15,
                      decoration: BoxDecoration(
                        color: ConsColors.yellowBKProfile,
                        borderRadius: BorderRadius.circular(width * 0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            // رنگ سایه با شفافیت
                            spreadRadius: 2,
                            // میزان پخش شدن
                            blurRadius: 8,
                            // میزان محو شدن
                            offset: Offset(0, 8), // فاصله از بالا و چپ/راست
                          ),
                        ],
                      ),

                      child: SvgPicture.asset("assets/images/iconProfile.svg"),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TxtTitle(text: "کاربر", color: Colors.white , size: 16,),
                          TxtTitleForNumberPhone(text: "+989178901122", color: Colors.white , size: 12,),
                        ],
                      ),
                    ),
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
