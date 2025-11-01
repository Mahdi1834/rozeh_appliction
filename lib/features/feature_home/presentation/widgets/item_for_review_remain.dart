import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/txt_medium.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

class ItemForReviewRemain extends StatelessWidget {
  const ItemForReviewRemain({super.key, required this.countReview, required this.countRemain});

  final String countReview;
  final String countRemain;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ConsColors.yellowLight,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 5),
                TxtMedium(text: "مرورهای انجام شده", sizeText: 12),
                SizedBox(width: 5),
                TxtTitle(text: countReview, color: ConsColors.orange, size: 12),

                SizedBox(width: 10),
                TxtMedium(text: "مانده", sizeText: 12),
                SizedBox(width: 5),
                TxtTitle(text: countRemain, color: ConsColors.orange, size: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
