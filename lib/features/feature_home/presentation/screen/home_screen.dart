import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/custom_btn_icon_menu.dart';
import 'package:rozeh_project/core/widgets/txt_for_quran.dart';
import 'package:rozeh_project/core/widgets/txt_header.dart';
import 'package:rozeh_project/core/widgets/txt_medium.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/fancy_card.dart';



class HomeScreen extends StatefulWidget {
  static const routePath = "/Home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool isFancyCardExpanded = true;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 50 && isFancyCardExpanded) {
      setState(() {
        isFancyCardExpanded = false;
      });
    } else if (_scrollController.offset <= 50 && !isFancyCardExpanded) {
      setState(() {
        isFancyCardExpanded = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          color: ConsColors.yellowLight,
          child: Column(
            children: [
              Container(
                width: width,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [ConsColors.green2, ConsColors.green],
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
                      child: SvgPicture.asset(
                        height: height * 0.15,
                        "assets/images/logo_top_left.svg",
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        height: height * 0.15,
                        "assets/images/logo_top_right.svg",
                      ),
                    ),
                    Positioned(
                      top: height * 0.071,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                            color: ConsColors.yellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: TxtTitle(
                              color: ConsColors.orange,
                              text: "سرچشمه شوق",
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.02),
                          Row(
                            children: [
                              CustomBtnIconMenu(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                imageUrl: "assets/images/menu.svg",
                              ),
                              Expanded(
                                child: Center(
                                  child: TxtHeader(
                                    text: "دیجی حفظ، معلم هوشمند قرآنی",
                                  ),
                                ),
                              ),
                              CustomBtnIconMenu(
                                onTap: () {
                                  // context.goNamed(SearchScreen.routeNameHome);
                                },
                                imageUrl: "assets/images/Search.svg",
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 40,
                                maxHeight: height * 0.25,
                                minWidth: width, // حداقل ارتفاع 50
                                maxWidth: width, // عرض همیشه پر
                              ),
                              child: FancyCard(
                                child:
                                    isFancyCardExpanded
                                        ? SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [

                                                SizedBox(
                                                  width: width,
                                                  child: TxtMedium(
                                                    text:
                                                        "قال رسول الله (صلی الله علیه و آله و سلم)",
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                TxtForQuran(
                                                  text:
                                                      "«حَمَلَةُ القُرْآنِ هُمُ المَحْفُوفونَ بِرَحمَةِ اللهِ، المُلَبِّسونَ نُورَ اللهِ، المُعَلِّمونَ كَلامَ اللهِ مَنْ عاداهُم فَقَدْ عادَی اللهَ و مَنْ والاهُم فَقَدْ والَی اللهَ»",
                                                ),
                                                SizedBox(height: 5),
                                                TxtMedium(
                                                  isAlignCenter: false,
                                                  text:
                                                      "حافظان قرآن مشمول رحمت خدا، در بركنندگان نور خدا و آموزگاران كلام خدایند. كسی كه با آنان دوستی نماید باخدادوستی نموده است.",
                                                ),
                                                SizedBox(height: 10),
                                                SizedBox(
                                                  width: width,
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: TxtTitleNotBold(
                                                      size: 12,
                                                      text:
                                                          "(مستدرك الوسائل /ج۴/ص ۲۵۴)",
                                                      color: ConsColors.blue,
                                                    ),
                                                  ),
                                                ),
                                                // TxtMedium(
                                                //   isAlignCenter: true,
                                                //   text: "(مستدرك الوسائل /ج۴/ص ۲۵۴)",
                                                // ),
                                              ],
                                            ),
                                          ),
                                        )
                                        : SizedBox.shrink(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          height: height * 0.15,
                          "assets/images/mandala.svg",
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.15,
                          "assets/images/mandala (1).svg",
                        ),
                      ),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

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
