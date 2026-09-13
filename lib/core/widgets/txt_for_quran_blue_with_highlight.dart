import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class TxtForQuranBlueWithHighLight extends StatelessWidget {
  const TxtForQuranBlueWithHighLight({
    super.key,
    required this.ayat,
    required this.currentIndex,
    this.height = 2,
    this.fontSize = 14,
    this.wordSpacing = 2,
    this.isPlaying = false, // 👈 اضافه شد
  });

  final List<String> ayat;
  final int currentIndex;
  final double height;
  final double fontSize;
  final double wordSpacing;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      text: TextSpan(children: _buildStyledText(context)),
    );
  }

  List<TextSpan> _buildStyledText(BuildContext context) {
    final regex = RegExp(r'\(\d+\)');
    List<TextSpan> spans = [];

    for (int i = 0; i < ayat.length; i++) {
      final input = ayat[i];
      final matches = regex.allMatches(input);
      int lastIndex = 0;

      for (final match in matches) {
        if (match.start > lastIndex) {
          final normalText = input.substring(lastIndex, match.start);
          spans.add(
            TextSpan(
              text: normalText.toPersianDigit(),
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: _getTextColor(context, i, isNumber: false),
                fontFamily: 'IRANSansX',
                height: height,
                wordSpacing: wordSpacing,
              ),
            ),
          );
        }

        final numberText = input.substring(match.start, match.end);
        spans.add(
          TextSpan(
            text: numberText.toPersianDigit(),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: _getTextColor(context, i, isNumber: true),
              fontFamily: 'IRANSansX',
              height: height,
              wordSpacing: wordSpacing,
            ),
          ),
        );

        lastIndex = match.end;
      }

      if (lastIndex < input.length) {
        final remainingText = input.substring(lastIndex);
        spans.add(
          TextSpan(
            text: '${remainingText.toPersianDigit()} ',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: _getTextColor(
                context,
                i,
                isNumber: false,
                isRemaining: true,
              ),
              fontFamily: 'IRANSansX',
              height: height,
              wordSpacing: wordSpacing,
            ),
          ),
        );
      }
    }

    return spans;
  }

  /// انتخاب رنگ بر اساس وضعیت بازی و آیه جاری
  Color _getTextColor(
    BuildContext context,
    int index, {
    bool isNumber = false,
    bool isRemaining = false,
  }) {
    if (!isPlaying) {
      // 👈 در حالت عادی (قبل از شروع چشم‌خوانی)
      return isNumber
          ? context.appColors.warning
          : context.appColors.textPrimary;
    }

    if (index == currentIndex) {
      if (isNumber) return context.appColors.warning;
      if (isRemaining) return context.appColors.warning;
      return context.appColors.textPrimary;
    }

    // 👈 وقتی در حالت چشم‌خوانی هستیم و این آیه جاری نیست → محو کن
    return Colors.transparent;
  }
}
