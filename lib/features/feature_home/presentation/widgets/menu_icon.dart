import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    super.key,
    required this.title,
    required this.svgUrl,
    required this.onTap,
  });

  final String title;
  final String svgUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // چون همیشه ۴ تا آیتم هست، عرض هر آیتم میشه ۱/۴ صفحه
    var itemWidth = screenWidth / 4.5;
    var itemHeight = screenHeight * 0.10;

    return SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // کادر اصلی
          InkWell(
            onTap: onTap,
            child: Container(
              height: itemHeight * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: itemHeight * 0.35),
                child: TxtTitle(
                  text: title,
                  color: ConsColors.blue,
                  size: 14,
                ),
              ),
            ),
          ),

          // دایره وسط بالا
          Positioned(
            bottom: itemHeight * 0.4,
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: itemHeight * 0.6,   // نسبت به ارتفاع
                height: itemHeight * 0.6,  // دایره
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  gradient: const LinearGradient(
                    colors: [ConsColors.orange, ConsColors.orange2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: ConsColors.orangeShadow,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    svgUrl,
                    width: itemHeight * 0.3,
                    height: itemHeight * 0.3,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

