import 'package:flutter/material.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_home/data/info_reservation_model.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/custom_txt_with_title.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class ExpandableReservationCard extends StatefulWidget {
  final InfoReservationModel infoReservationModel;

  const ExpandableReservationCard({
    super.key,
    required this.infoReservationModel,
  });

  @override
  _ExpandableReservationCardState createState() =>
      _ExpandableReservationCardState();
}

class _ExpandableReservationCardState extends State<ExpandableReservationCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: context.appColors.navigationBackground,
              boxShadow: [
                BoxShadow(
                  color: context.appColors.warning.withValues(alpha: 0.8),
                  blurRadius: 5.3,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TxtTitle(
                        text: widget.infoReservationModel.title,
                        color: context.appColors.textPrimary,
                      ),
                    ),
                    TxtTitle(
                      text: widget.infoReservationModel.date,
                      color: context.appColors.textPrimary,
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: [context.appColors.warning, context.appColors.warning2],
                        ),
                      ),
                      child: Icon(
                        size: 15,
                        color: Colors.white,
                        isExpanded
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_left_outlined,
                      ),
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Divider(color: context.appColors.warning),
                        CustomTxtWithTitle(
                          title: "نام مداح:",
                          content: widget.infoReservationModel.maddah,
                        ),
                        SizedBox(height: 10),
                        CustomTxtWithTitle(
                          title: "نام سخنران:",
                          content: widget.infoReservationModel.speaker,
                        ),
                        SizedBox(height: 10),
                        CustomTxtWithTitle(
                          title: "نوع مراسم:",
                          content: widget.infoReservationModel.type,
                        ),
                        SizedBox(height: 10),
                        CustomTxtWithTitle(
                          title: "مخاطبین :",
                          content: widget.infoReservationModel.gender,
                        ),
                        SizedBox(height: 10),
                        CustomTxtWithTitle(
                          title: "ادرس :",
                          content: widget.infoReservationModel.address,
                        ),
                      ],
                    ),
                  ),
                  crossFadeState:
                  isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),

        // محتوای اضافی
      ],
    );
  }
}



