import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';

class ItemForBottomNav extends StatelessWidget {
  const ItemForBottomNav({
    super.key,
    required this.pageNumber,
    required this.imageUrl,
    required this.state,
    required this.title,
    required this.onTap,
  });

  final int pageNumber;
  final String imageUrl;
  final int state;

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            SvgPicture.asset(
              imageUrl,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                state == pageNumber ? ConsColors.orange : ConsColors.gray,
                BlendMode.srcIn,
              ),
            ),

            Text(
              title,
              style: TextStyle(
                color:
                    state == pageNumber
                        ? ConsColors.orange
                        : ConsColors.blue,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2, bottom: 2),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color:
                    state == pageNumber
                        ? ConsColors.orange
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
