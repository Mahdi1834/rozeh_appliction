import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TxtForQuranBlue extends StatelessWidget {
  const TxtForQuranBlue({
    super.key,
    required this.text,
    this.height = 2,
    this.fontSize = 14,
    this.wordSpacing = 2,
    this.txtColor= ConsColors.blue,
  });

  final String text;
  final double height;
  final double fontSize;
  final double wordSpacing;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      text: TextSpan(children: _buildStyledText(text)),
    );
  }

  List<TextSpan> _buildStyledText(String input) {
    final regex = RegExp(r'\(\d+\)'); // تشخیص اعداد داخل پرانتز به انگلیسی
    final matches = regex.allMatches(input);

    int lastIndex = 0;
    List<TextSpan> spans = [];

    for (final match in matches) {
      // متن معمولی قبل از عدد
      if (match.start > lastIndex) {
        final normalText = input.substring(lastIndex, match.start);
        spans.add(
          TextSpan(
            text: normalText.toPersianDigit(), // تبدیل به فارسی
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: txtColor,
              fontFamily: 'IRANSansX',
              height: 2,
              wordSpacing: wordSpacing,
            ),
          ),
        );
      }

      // عدد داخل پرانتز به رنگ نارنجی با تبدیل به فارسی
      final numberText = input.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: numberText.toPersianDigit(),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: ConsColors.orange,
            height: 2,
            fontFamily: 'IRANSansX',
            wordSpacing: wordSpacing,
          ),
        ),
      );

      lastIndex = match.end;
    }

    // متن باقی‌مانده پس از آخرین عدد
    if (lastIndex < input.length) {
      final remainingText = input.substring(lastIndex);
      spans.add(
        TextSpan(
          text: remainingText.toPersianDigit(),
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'IRANSansX',
            fontWeight: FontWeight.bold,
            color: ConsColors.blue,
            height: 2,
            wordSpacing: wordSpacing,
          ),
        ),
      );
    }

    return spans;
  }
}
