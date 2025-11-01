import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/src/nav_item.dart';
import 'package:flutter/material.dart';

class NavItemWidget extends StatelessWidget {
  final NavItem item;
  final bool isSelected;

  const NavItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorText = isSelected ? ConsColors.orange: ConsColors.blue;
    final colorIcon = isSelected ? ConsColors.orange: ConsColors.gray;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          item.svgPath,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(colorIcon, BlendMode.srcIn),
        ),
        SizedBox(height: 4),
        Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            color: colorText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            shadows: isSelected
                ? [
              Shadow(
                offset: Offset(0, 2), // سایه به پایین
                blurRadius: 5,
                color: Colors.orange.withValues(alpha:0.2),
              ),
            ]
                : [],
          ),
        ),
      ],
    );
  }
}
