import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';

import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';

class HelpScreen extends StatefulWidget {
  static const routePath = "/help_screen";

  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
                title: "راهنمای استفاده از اپلیکیشن",
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
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TxtTitle(
                                  size: 16,
                                  text:
                                      "راهنمای استفاده از اپلیکیشن رزرو روضه‌های خانگی",
                                  color: ConsColors.orange,
                                ),

                                TxtTitleNotBold(
                                  text:
                                      "به اپلیکیشن رزرو روضه‌های خانگی خوش آمدید.\n با استفاده از این برنامه، می‌توانید به‌سادگی مراسم مذهبی خود را برنامه‌ریزی و رزرو کنید. کافی است مراحل زیر را به ترتیب انجام دهید:",
                                  color: ConsColors.blue,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TxtTitle(
                                        size: 16,
                                        text: "1. احراز هویت: ",
                                        color: ConsColors.orange,
                                      ),

                                      TxtTitleNotBold(
                                        textAlign: TextAlign.justify,

                                        text:
                                            "در ابتدا اطلاعات هویتی و تماس خود را وارد کنید تا حساب کاربری شما تأیید و هماهنگی‌های لازم با شما انجام شود.",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 10),

                                      ///////////////
                                      TxtTitle(
                                        size: 16,
                                        text: "2. انتخاب مداح یا سخنران: ",
                                        color: ConsColors.orange,
                                      ),

                                      TxtTitleNotBold(
                                        textAlign: TextAlign.justify,

                                        text:
                                            "از میان مداحان و سخنرانان موجود در سامانه، گزینه‌ی مورد نظر خود را انتخاب کنید. در صورت تمایل می‌توانید انتخاب را به سیستم بسپارید تا مناسب‌ترین فرد را برای شما پیشنهاد دهد.",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 10),

                                      ///////////////
                                      TxtTitle(
                                        size: 16,
                                        text: "3. تعیین تاریخ مراسم: ",
                                        color: ConsColors.orange,
                                      ),

                                      TxtTitleNotBold(
                                        textAlign: TextAlign.justify,

                                        text:
                                            "از تقویم برنامه، تاریخ دلخواه خود را برای برگزاری مراسم انتخاب نمایید.",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 10),

                                      ///////////////
                                      TxtTitle(
                                        size: 16,
                                        text: "4. انتخاب زمان برگزاری: ",
                                        color: ConsColors.orange,
                                      ),

                                      TxtTitleNotBold(
                                        textAlign: TextAlign.justify,

                                        text:
                                            "ساعت مورد نظر خود را از میان زمان‌های در دسترس مشخص کنید تا رزرو شما دقیق‌تر ثبت شود.",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 10),

                                      ///////////////
                                      TxtTitle(
                                        size: 16,
                                        text: "5. انتخاب نوع مراسم: ",
                                        color: ConsColors.orange,
                                      ),

                                      TxtTitleNotBold(
                                        textAlign: TextAlign.justify,

                                        text:
                                            "نوع برنامه‌ی مذهبی را مشخص کنید (روضه، سخنرانی، مولودی، دعا و ...).",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 10),

                                      ///////////////
                                      TxtTitle(
                                        size: 16,
                                        text: "6. تعیین رنج سنی شرکت‌کنندگان: ",
                                        color: ConsColors.orange,
                                      ),

                                      TxtTitleNotBold(
                                        textAlign: TextAlign.justify,

                                        text:
                                            "گروه سنی مخاطبان مراسم را انتخاب کنید تا هماهنگی محتوا و نحوه‌ی برگزاری به شکل مناسب‌تری انجام گیرد.",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 10),

                                      ///////////////
                                      TxtTitle(
                                        size: 16,
                                        text: "7.انتخاب جنسیت شرکت‌کنندگان: ",
                                        color: ConsColors.orange,
                                      ),

                                      TxtTitleNotBold(
                                        textAlign: TextAlign.justify,

                                        text:
                                            "مشخص کنید مراسم ویژه‌ی بانوان است، آقایان یا مختلط، تا سیستم متناسب با شرایط شما برنامه‌ریزی کند.",
                                        color: ConsColors.blue,
                                      ),
                                      SizedBox(height: 10),

                                      ///////////////
                                    ],
                                  ),
                                ),

                                TxtTitleNotBold(
                                  textAlign: TextAlign.justify,

                                  text:
                                      "در پایان، با تأیید نهایی رزرو، اطلاعات مراسم برای شما ثبت شده و پیام تأیید برایتان ارسال می‌شود.",
                                  color: ConsColors.blue,
                                ),
                                SizedBox(height: 10),
                                TxtTitle(
                                  text:
                                      " لطفاً در وارد کردن اطلاعات دقت کنید تا فرایند هماهنگی بدون هیچ مشکلی انجام شود.",
                                  color: ConsColors.blue,
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
            ],
          ),
        ),
      ),
    );
  }
}
