import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rozeh_project/core/config/colors.dart';

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ConsColors.borderInactive,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ConsColors.borderActive,
            width: 1.5,
          ),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        // این خط باعث میشه همیشه زیر باز بشه
        direction: DropdownDirection.textDirection, // یا DropdownDirection.down
      ),
      iconStyleData: IconStyleData(
        icon: SvgPicture.asset("assets/images/dropdown.svg"),
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: ConsColors.blue,
      ),
    );
  }
}
