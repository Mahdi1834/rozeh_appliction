import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomDropdownField<T> extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
    this.hintText,
    this.isTextStart = true,
    this.enableSearch = true,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T? value;
  final String? hintText;
  final bool isTextStart;
  final bool enableSearch;

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      value: widget.value,
      items: widget.items,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: ConsColors.blueLight,
        hintText: widget.hintText?.toPersianDigit(),
        hintStyle: TextStyle(
          color: ConsColors.blue.withValues(alpha: 0.25),
          fontFamily: 'IRANSansX',
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ConsColors.blue, width: 1.5),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        // direction: DropdownDirection.down,
      ),
      iconStyleData: IconStyleData(
        icon: SvgPicture.asset("assets/images/dropdown.svg"),
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: ConsColors.blue,
        fontFamily: 'IRANSansX',
      ),
      dropdownSearchData:
          widget.enableSearch
              ? DropdownSearchData(
                searchInnerWidgetHeight: 50,
                searchController: _searchController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'جستجو...',
                      hintStyle: TextStyle(
                        color: ConsColors.blue.withValues(alpha: 0.3),
                        fontFamily: 'IRANSansX',
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: ConsColors.blue.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  final text = (item.child as Text).data ?? "";
                  return text.toLowerCase().contains(searchValue.toLowerCase());
                },
              )
              : null,
    );
  }
}
