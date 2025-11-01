import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/custom_icon_btn.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/item_for_review_remain.dart';


class ItemTimer extends StatelessWidget {
  const ItemTimer({
    super.key,
    required this.countReview,
    required this.countRemain,
    required this.title,
    required this.onPressed,
    required this.subTitle,
    this.titleColor = ConsColors.blue,
    required this.isShowBgYellow,
  });

  final String countReview;
  final String countRemain;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;
  final Color titleColor;
  final bool isShowBgYellow;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TxtTitle(
                text: title,
                size: 16,
                color: titleColor,
              ),
            ),
            CustomIconBtn(
              title: "شروع کنیم",
              onPressed: onPressed,
              useGradient: false, // یا false برای Transparent
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 5),
            Icon(size: 5, Icons.circle, color: ConsColors.blue),
            SizedBox(width: 5),
            TxtTitleNotBold(text: subTitle, size: 12 ,color: ConsColors.gray,),
          ],
        ),
        SizedBox(height: 5),
      if(isShowBgYellow) ItemForReviewRemain(countReview: countReview, countRemain: countRemain),
      ],
    );
  }
}
