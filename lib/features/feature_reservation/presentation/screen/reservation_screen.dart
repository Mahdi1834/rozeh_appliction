import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';


class ReservationScreen extends StatefulWidget {
  static const routePath = "/reservation_screen";

  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: ConsColors.blueLight,
          child: Column(
            children: [
              CustomAppBarWithSearch(
                mainContext: context,
                title: "فرم ثبت درخواست رزرو",
                onTapSearch: () {},
              ),

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
                        ),
                      ),
                      Positioned(
                        top: height * 0.2,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala (1).svg",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
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
