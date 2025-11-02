import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/custom_btn_icon_menu.dart';
import 'package:rozeh_project/core/widgets/custom_icon_svg_btn.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/txt_for_quran.dart';
import 'package:rozeh_project/core/widgets/txt_header.dart';
import 'package:rozeh_project/core/widgets/txt_medium.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/features/feature_home/data/info_reservation_model.dart';
import 'package:rozeh_project/features/feature_home/data/model/current_hadith_model.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/expandable_reservation_card.dart';
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
  InfoReservationModel infoReservationModel = InfoReservationModel(
    title: "مراسم رزرو شده",
    date: "1404/09/10",
    maddah: "مهدی ",
    speaker: "مهران ",
    type: "وفات",
    gender: "بانوان",
  );

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetCurrentHadithEvent());
    _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);
  }

  // void _scrollListener() {
  //   final offset = _scrollController.offset;
  //   if (offset > 80 && isFancyCardExpanded) {
  //     setState(() => isFancyCardExpanded = false);
  //   } else if (offset < 20 && !isFancyCardExpanded) {
  //     setState(() => isFancyCardExpanded = true);
  //   }
  // }

  @override
  void dispose() {
    // _scrollController.dispose();
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
          color: ConsColors.blueLight,
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
                                    text: "رزرو روضه و مجالس خانگی",
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
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: BlocConsumer<HomeBloc, HomeState>(
                                        listener: (context, state) {
                                          // TODO: implement listener
                                        },
                                        builder: (context, state) {
                                          if (state.currentHadithStatus
                                              is CurrentHadithStatusLoading) {
                                            return DotLoadingWidget(size: 50);
                                          }
                                          if (state.currentHadithStatus
                                              is CurrentHadithStatusCompleted) {
                                            CurrentHadithStatusCompleted
                                            currentHadithStatusCompleted =
                                                state.currentHadithStatus
                                                    as CurrentHadithStatusCompleted;

                                            CurrentHadithModel
                                            currentHadithModel =
                                                currentHadithStatusCompleted
                                                    .currentHadithModel;

                                            return SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width,
                                                      child: TxtMedium(
                                                        text:currentHadithModel.data?.currentHadith?.author ?? "",
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    TxtForQuran(
                                                      text:currentHadithModel.data?.currentHadith?.contentAr ?? "",
                                                    ),
                                                    SizedBox(height: 5),
                                                    TxtMedium(
                                                      isAlignCenter: true,
                                                      text:currentHadithModel.data?.currentHadith?.contentFa ?? "",
                                                    ),
                                                    SizedBox(height: 10),
                                                    SizedBox(
                                                      width: width,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: TxtTitleNotBold(
                                                          size: 12,
                                                          text:currentHadithModel.data?.currentHadith?.source ?? "",

                                                          color:
                                                              ConsColors.blue,
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
                                            );
                                          }
                                          if (state.currentHadithStatus
                                              is CurrentHadithStatusError) {
                                            return IconButton(
                                              onPressed: () {
                                                BlocProvider.of<HomeBloc>(
                                                  context,
                                                ).add(GetCurrentHadithEvent());
                                              },
                                              icon: Icon(
                                                Icons.refresh,
                                                color: ConsColors.green,
                                              ),
                                            );
                                          }
                                          return SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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
                        top: 20,
                        left: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,

                          "assets/images/mandala.svg",
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala (1).svg",
                        ),
                      ),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(10),
                        child:
                            false
                                ? SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: height * 0.09),
                                      TxtTitle(
                                        isAlignCenter: true,
                                        size: 18,
                                        text:
                                            "کاربر عزیز   \n برای رزرو مجالس و روضه های خانگی خود فرم ثبت درخواست را تکمیل نمایید",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: width * 0.8,
                                        child: CustomSvgIconBtn(
                                          title: "رزرو",
                                          onPressed: () {},
                                          svgPicture: "assets/images/Add.svg",
                                          useGradient: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    TxtTitle(
                                      size: 18,
                                      text: "برنامه مراسم رزرو شده برای شما",
                                      color: ConsColors.blue,
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: NotificationListener<
                                        ScrollNotification
                                      >(
                                        onNotification: (scrollInfo) {
                                          if (scrollInfo
                                              is ScrollUpdateNotification) {
                                            final offset =
                                                scrollInfo.metrics.pixels;

                                            if (offset > 120 &&
                                                isFancyCardExpanded) {
                                              setState(
                                                () =>
                                                    isFancyCardExpanded = false,
                                              );
                                            } else if (offset < 10 &&
                                                !isFancyCardExpanded) {
                                              setState(
                                                () =>
                                                    isFancyCardExpanded = true,
                                              );
                                            }
                                          }
                                          return false;
                                        },
                                        child: SingleChildScrollView(
                                          controller: _scrollController,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ExpandableReservationCard(
                                                infoReservationModel:
                                                    infoReservationModel,
                                              ),
                                              ExpandableReservationCard(
                                                infoReservationModel:
                                                    infoReservationModel,
                                              ),
                                              ExpandableReservationCard(
                                                infoReservationModel:
                                                    infoReservationModel,
                                              ),
                                              ExpandableReservationCard(
                                                infoReservationModel:
                                                    infoReservationModel,
                                              ),
                                              ExpandableReservationCard(
                                                infoReservationModel:
                                                    infoReservationModel,
                                              ),
                                              ExpandableReservationCard(
                                                infoReservationModel:
                                                    infoReservationModel,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
