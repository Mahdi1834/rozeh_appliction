import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:rozeh_project/core/config/colors.dart';

class CustomMultiDropdown extends StatefulWidget {
  final List<DropdownItem<String>> options;
  final List<String> selected;
  final void Function(List<String>) onChanged;
  final String hintText;

  const CustomMultiDropdown({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.hintText = 'انتخاب کنید',
  });

  @override
  State<CustomMultiDropdown> createState() => _CustomMultiDropdownState();
}

class _CustomMultiDropdownState extends State<CustomMultiDropdown> {
  late MultiSelectController<String> controller;

  @override
  void initState() {
    super.initState();
    controller = MultiSelectController<String>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<String>(
      items: widget.options,
      controller: controller,
      onSelectionChange: (items) {
        // ارسال فقط مقدار رشته‌ها به بیرون
        widget.onChanged(items.map((e) => e).toList());
      },

      fieldDecoration: FieldDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SvgPicture.asset("assets/images/dropdown.svg"),
        ),

        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600 , fontSize: 14 ),
        // prefixIcon: const Icon(Icons.list_alt_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ConsColors.borderInactive),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ConsColors.green, width: 1.5),
        ),
      ),

      chipDecoration: ChipDecoration(
        backgroundColor: ConsColors.orange.withValues(alpha:0.1),
        labelStyle: TextStyle(color: ConsColors.orange),
        wrap: true,
      ),
      dropdownItemDecoration: DropdownItemDecoration(
        selectedTextColor: ConsColors.blue,
        textColor: ConsColors.blue,
        backgroundColor: Colors.white,
        selectedIcon: Icon(Icons.check_box, color: ConsColors.orange),
        selectedBackgroundColor: ConsColors.orange.withAlpha(15),
        disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
      ),
      dropdownDecoration: const DropdownDecoration(
        backgroundColor: Colors.white,
        maxHeight: 250,
        elevation: 5,
        marginTop: -5,
      ),
      searchEnabled: false,
    );
  }
}
