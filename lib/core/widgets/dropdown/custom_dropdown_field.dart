import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return DropdownButtonFormField2<T>(
      isExpanded: true,
      value: widget.value,
      items: widget.items,
      onChanged: widget.onChanged,

      // ------------------------------------------------------------
      // Main field
      // ------------------------------------------------------------
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.inputBackground,

        hintText: widget.hintText?.toPersianDigit(),
        hintStyle: TextStyle(
          color: colors.textPrimary.withValues(alpha: 0.25),
          fontFamily: 'IRANSansX',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),

        isDense: true,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent, width: 1),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.textPrimary, width: 1.5),
        ),
      ),

      // ------------------------------------------------------------
      // Selected value text
      // ------------------------------------------------------------
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: colors.textPrimary,
        fontFamily: 'IRANSansX',
      ),

      // ------------------------------------------------------------
      // Dropdown popup
      // ------------------------------------------------------------
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.inputBackground,
        ),
      ),

      // ------------------------------------------------------------
      // Dropdown arrow
      // ------------------------------------------------------------
      iconStyleData: IconStyleData(
        icon: SvgPicture.asset(
          "assets/images/dropdown.svg",
          colorFilter: ColorFilter.mode(colors.warning, BlendMode.srcIn),
          width: 20,
          height: 20,
        ),
      ),

      // ------------------------------------------------------------
      // Search
      // ------------------------------------------------------------
      dropdownSearchData:
          widget.enableSearch
              ? DropdownSearchData(
                searchInnerWidgetHeight: 58,
                searchController: _searchController,

                searchInnerWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    textDirection: TextDirection.rtl,

                    style: TextStyle(
                      color: colors.textPrimary,
                      fontFamily: 'IRANSansX',
                      fontSize: 14,
                    ),

                    cursorColor: colors.warning,

                    decoration: InputDecoration(
                      hintText: 'جستجو...',

                      hintStyle: TextStyle(
                        color: colors.textPrimary.withValues(alpha: 0.3),
                        fontFamily: 'IRANSansX',
                        fontSize: 14,
                      ),

                      filled: true,
                      fillColor: colors.background,

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.textPrimary.withValues(alpha: 0.2),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: colors.warning,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                searchMatchFn: (item, searchValue) {
                  final child = item.child;

                  if (child is Text) {
                    final text = child.data ?? '';

                    return text.toLowerCase().contains(
                      searchValue.toLowerCase(),
                    );
                  }

                  return false;
                },
              )
              : null,
    );
  }
}


