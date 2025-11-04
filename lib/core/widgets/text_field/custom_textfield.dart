import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.isShowText = false,
    this.hintText,
    this.isTextStart = false,
    this.readOnly = false,
    this.validator, // 👈 اضافه شد
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isShowText;
  final String? hintText;
  final bool isTextStart;
  final bool readOnly;
  final String? Function(String?)? validator; // 👈 اضافه شد

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<TextInputFormatter> _getInputFormatters() {
    final formatters = <TextInputFormatter>[];

    if (widget.textInputType == TextInputType.phone) {
      formatters.add(LengthLimitingTextInputFormatter(10));
    }

    formatters.add(
      TextInputFormatter.withFunction((oldValue, newValue) {
        final persianText = newValue.text.toPersianDigit();
        return TextEditingValue(
          text: persianText,
          selection: newValue.selection,
          composing: newValue.composing,
        );
      }),
    );

    return formatters;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      inputFormatters: _getInputFormatters(),
      textDirection: TextDirection.rtl,
      textAlign: widget.isTextStart ? TextAlign.start : TextAlign.center,
      cursorColor: ConsColors.blueBg1,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: ConsColors.blue,
        fontFamily: 'IRANSansX',
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: ConsColors.blueLight,
        hintText: widget.hintText?.toPersianDigit(),
        hintStyle: TextStyle(
          color: ConsColors.blue.withValues(alpha: 0.25),
          fontFamily: 'IRANSansX',
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ConsColors.blue, width: 1.5),
        ),
        suffixIcon: widget.isShowText
            ? Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            '98+'.toPersianDigit(),
            style: TextStyle(
              color: ConsColors.blue,
              fontWeight: FontWeight.bold,
              fontFamily: 'IRANSansX',
            ),
          ),
        )
            : null,
      ),
      validator: widget.validator, // 👈 اضافه شد
    );
  }
}
