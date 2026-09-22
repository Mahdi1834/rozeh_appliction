import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/core/widgets/custom_btn.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/show_fancy_bottom_sheet.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/features/feature_help/presentation/screen/help_screen.dart';
import 'package:rozeh_project/features/feature_list_profile/presentation/screen/profile_menu_screen.dart';
import 'package:rozeh_project/features/feature_login/presentation/screen/login_screen.dart';
import 'package:rozeh_project/features/feature_mainwrapper/presentation/widgets/item_for_drawer.dart';
import 'package:rozeh_project/locator.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

Drawer buildDrawer(double width, BuildContext context) {
  return Drawer(
    backgroundColor: context.appColors.navigationBackground,
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
              colors: [
                context.appColors.appBarBackground,
                context.appColors.appBarSecondary,
              ],
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
                  color: Colors.white.withValues(alpha: 0.3),
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
                    context.go(ProfileMenuScreen.routePath);
                  },
                  title: "پروفایل",
                ),

                Divider(color: context.appColors.inputBackground),
                ItemForDrawer(
                  svgPic: "assets/images/Info square.svg",
                  onTap: () {
                    context.go(HelpScreen.routePath);
                  },
                  title: "راهنمای برنامه",
                ),
                Divider(color: context.appColors.inputBackground),
                ItemForDrawer(
                  svgPic: "assets/images/Message square.svg",
                  onTap: () {},
                  title: "پشتیبانی",
                ),
                Divider(color: context.appColors.inputBackground),
                ItemForDrawer(
                  svgPic: "assets/images/Share.svg",
                  onTap: () {},
                  title: "اشتراک گذاری برنامه",
                ),
                Divider(color: context.appColors.inputBackground),
                ItemForDrawer(
                  svgPic: "assets/images/Logout.svg",
                  onTap: () async {
                    Navigator.of(context).pop(); // بستن Drawer
                    showLogoutBottomSheet(context);
                  },

                  title: "خروج از حساب",
                ),
                Divider(color: context.appColors.inputBackground),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void showLogoutBottomSheet(BuildContext context) {
  showFancyBottomSheet(
    context: context,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TxtTitle(
            text: "خروج از حساب کاربری",
            color: context.appColors.textPrimary,
            size: 16,
          ),

          const SizedBox(height: 10),

          TxtTitleNotBold(
            text: "آیا تمایل دارید از حساب کاربری خود خارج شوید؟",
            color: context.appColors.secondary,
            size: 14,
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              Expanded(
                child: CustomBtn(
                  onPressed: () {
                    Navigator.pop(context); // فقط بستن BottomSheet
                  },
                  title: "انصراف",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomBtnGradient(
                  title: "بله، خروج",
                  onPressed: () async {
                    Navigator.pop(context); // بستن BottomSheet

                    UserSession userSession = locator();
                    await userSession.clearAll();

                    context.go(LoginScreen.routePath);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
