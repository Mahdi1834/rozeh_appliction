import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class CustomTxtWithTitle extends StatelessWidget {
  final String title;
  final String content;

  const CustomTxtWithTitle({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TxtTitleNotBold(text: title, color: context.appColors.textSecondary),
        SizedBox(width: 10),
        Expanded(child: TxtTitle(text: content, color: context.appColors.textPrimary)),
      ],
    );
  }
}
