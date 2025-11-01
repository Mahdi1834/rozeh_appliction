import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_txt_one_icon.dart';

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
          color: ConsColors.yellowLight,

          child: Column(
            children: [
              CustomAppBarWithTextOneIcon(
                mainContext: context,
                title: "دیجی حفظ، معلم هوشمند قرآنی",
                text: "راهنمایی های شما",
                onPress: () {},
                url: "assets/images/Share.svg",
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: SingleChildScrollView(child: Column()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
