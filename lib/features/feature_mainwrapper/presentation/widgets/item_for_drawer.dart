import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';

import 'package:rozeh_project/core/widgets/txt_title.dart';

class ItemForDrawer extends StatelessWidget {
  const ItemForDrawer({
    super.key,
    required this.onTap,
    required this.title,
    required this.svgPic,
    this.isArrow = false,
  });

  final VoidCallback onTap;
  final String title;
  final String svgPic;
  final bool isArrow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            SvgPicture.asset(
              width: 20,
              height: 20,
              svgPic,
              colorFilter: ColorFilter.mode(ConsColors.blue, BlendMode.srcIn),
            ),
            SizedBox(width: 10),
            Expanded(child: TxtTitle(text: title, color: ConsColors.blue)),
            isArrow
                ? Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 30,
                  color: ConsColors.orange,
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
