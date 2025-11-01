import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/txt_medium.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

class ItemTitleFirstTimer extends StatelessWidget {
  final String page;
  final String joz;

  const ItemTitleFirstTimer({super.key, required this.page, required this.joz});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TxtTitle(text: "حفظ جدید", size: 17, color: ConsColors.green),
        Row(
          children: [
            SizedBox(width: 5),
            Icon(size: 5, Icons.circle, color: ConsColors.blue),
            SizedBox(width: 5),
            TxtMedium(text: "حفظ صفحه ${page} / جز ${joz}", sizeText: 12),
          ],
        ),
      ],
    );
  }
}
