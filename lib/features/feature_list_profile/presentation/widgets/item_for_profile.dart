import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';

class ItemForProfile extends StatelessWidget {
  const ItemForProfile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onPress,
  });

  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: context.appColors.inputBackground,
          boxShadow: [
            BoxShadow(
              color: context.appColors.warning.withValues(alpha: 0.8),
              blurRadius: 5.3,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(imageUrl,color: context.appColors.primary,),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TxtTitle(
                    text: title,
                    color: context.appColors.textPrimary,
                  ),
                  TxtTitleNotBold(
                    text: description,
                    color: context.appColors.textPrimary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}