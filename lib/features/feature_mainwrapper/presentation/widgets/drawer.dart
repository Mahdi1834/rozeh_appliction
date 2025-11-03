import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rozeh_project/core/config/colors.dart';

import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_mainwrapper/presentation/widgets/item_for_drawer.dart';

Drawer buildDrawer(double width, BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
            gradient: LinearGradient(
              colors: [ConsColors.blueBg2, ConsColors.blueBg1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset("assets/images/menu.svg"),
              SizedBox(width: 10),
              Expanded(child: TxtTitle(text: "منو", color: Colors.white)),

              // CustomBtnIconMenu(imageUrl: "assets/images/close.svg", onTap:  () {
              //   Navigator.of(context).pop();
              // }),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha:0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close, size: 25, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ItemForDrawer(
                  svgPic: "assets/images/User.svg",
                  onTap: () {
                    // context.pushNamed(EditProfileScreen.routeName);
                  },
                  title: "پروفایل",
                ),
                // Divider(color: ConsColors.blueLight),
                // ItemForDrawer(
                //   svgPic: "assets/images/BookDr.svg",
                //   onTap: () {},
                //   isArrow: true,
                //   title: "برنامه حفظ",
                // ),
                // Divider(color: ConsColors.blueLight),
                // ItemForDrawer(
                //   svgPic: "assets/images/Bookmark.svg",
                //   onTap: () {},
                //   title: "نشان ها",
                // ),
                Divider(color: ConsColors.blueLight),
                ItemForDrawer(
                  svgPic: "assets/images/Settings.svg",
                  onTap: () {},
                  title: "تنظیمات",
                ),
                Divider(color: ConsColors.blueLight),
                ItemForDrawer(
                  svgPic: "assets/images/Info square.svg",
                  onTap: () {},
                  title: "راهنمای برنامه",
                ),
                Divider(color: ConsColors.blueLight),
                ItemForDrawer(
                  svgPic: "assets/images/Message square.svg",
                  onTap: () {},
                  title: "پشتیبانی",
                ),
                Divider(color: ConsColors.blueLight),
                ItemForDrawer(
                  svgPic: "assets/images/Share.svg",
                  onTap: () {},
                  title: "اشتراک گذاری برنامه",
                ),
                Divider(color: ConsColors.blueLight),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
