import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_txt_search.dart';





class CalenderScreen extends StatefulWidget {
  static const routePath = "/calender_screen";

  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
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
              CustomAppBarWithTextSearch(
                mainContext: context,
                title: "دیجی حفظ، معلم هوشمند قرآنی",
                text: "شروع دوره اول",
                text2: "( 15 اردیبهشت - 21 مرداد )",
                onTapSearch: () {

                },
              ),
              Expanded(
                child: SizedBox(
                  width: width,

                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        SizedBox(
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
                              SizedBox(
                                height: 10,
                                width: width,
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
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
