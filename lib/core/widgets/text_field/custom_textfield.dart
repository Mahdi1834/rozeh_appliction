import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.isShowText = false,
    this.hintText,
    this.isTextStart = false,
    this.readOnly = false,
    this.validator,
    this.suffixIcon,
    this.isCodeNational = false,
    this.mlength = 10
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isShowText;
  final String? hintText;
  final bool isTextStart;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool isCodeNational;
  final int mlength ;

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
      formatters.add(LengthLimitingTextInputFormatter(widget.mlength));
    }

    if(widget.isCodeNational){
      formatters.add(LengthLimitingTextInputFormatter(widget.mlength));
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
      minLines: 1,
      maxLines: widget.textInputType == TextInputType.multiline ? 6 : 1,
      cursorColor: context.appColors.secondary,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: context.appColors.textPrimary,
        fontFamily: 'IRANSansX',
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.appColors.inputBackground,
        hintText: widget.hintText?.toPersianDigit(),
        hintStyle: TextStyle(
          color: context.appColors.textPrimary.withValues(alpha: 0.25),
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
          borderSide: BorderSide(color: context.appColors.textPrimary, width: 1.5),
        ),
        suffixIcon: widget.suffixIcon ??
            (widget.isShowText
                ? Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                '98+'.toPersianDigit(),
                style: TextStyle(
                  color: context.appColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IRANSansX',
                ),
              ),
            )
                : null),

      ),
      validator: widget.validator, // 👈 اضافه شد
    );
  }
}
