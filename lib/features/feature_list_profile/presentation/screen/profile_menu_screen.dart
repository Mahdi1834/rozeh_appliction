import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/screen/list_address_screen.dart';
import 'package:rozeh_project/features/feature_list_profile/presentation/widgets/item_for_profile.dart';
import 'package:rozeh_project/features/feature_profile/presentation/screen/profile_screen.dart';

class ProfileMenuScreen extends StatefulWidget {
  static const routePath = "/profile_menu_screen";
  static const routeName = "profile_menu_screen";

  const ProfileMenuScreen({super.key});

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: context.appColors.background,
          child: Column(
            children: [
              CustomAppBarWithSearch(
                mainContext: context,
                title: "پروفایل کاربر",
                onTapSearch: () {},
              ),

              SizedBox(height: 10),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: height * 0.2,
                        left: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala.svg",
                          color: context.appColors.appBarSecondary,
                        ),
                      ),
                      Positioned(
                        top: height * 0.2,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala (1).svg",
                          color: context.appColors.appBarSecondary,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ItemForProfile(
                                title: "تکمیل پروفایل",
                                description: "تکمیل اطلاعات فردی و تحصیلی",
                                imageUrl: "assets/images/Calendar.svg",
                                onPress: () {
                                  context.pushNamed(ProfileScreen.routeName);
                                },
                              ),
                              ItemForProfile(
                                title: "مدیریت آدرس ها",
                                description: "اضافه،ویرایش و حذف ادرس ها",
                                imageUrl:
                                    "assets/images/location-pin-svgrepo-com.svg",
                                onPress: () {
                                  context.pushNamed(ListAddressScreen.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
